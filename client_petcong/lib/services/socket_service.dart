import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:petcong/pages/app_pages/matching/call_waiting_page.dart';
import 'package:petcong/pages/app_pages/matching/matching_page.dart';
import 'package:petcong/pages/app_pages/webRTC/webrtc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// stomp client
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class SocketService extends GetxController {
  // Socket 변수
  static StompClient? client;
  RxList<String> msgArr = <String>[].obs;
  String? uid;
  String? idToken;
  VoidCallback? onInitComplete;
  // RTC 변수
  // late MainVideoCall webrtc;
  RTCPeerConnection? pc;
  late String targetUid;
  String subsPrefix = "/queue/";
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  MediaStream? _localStream;

  Future<void> initPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      uid = prefs.getString('uid');
      idToken = prefs.getString('idToken');
    } catch (e) {
      debugPrint('Error retrieving values from SharedPreferences: $e');
    }
  }

  Future<void> init() async {
    try {
      await initPrefs();
      if (idToken == null) {
        debugPrint('idToken is null');
        return;
      }
      if (onInitComplete != null) {
        onInitComplete!();
      }
      debugPrint('!!!!!!!!!!!!!!!!!!!!!I get IdToken$uid!!!!!!!!!!!!!!');
    } catch (e) {
      debugPrint('Error during initialization: $e');
    }
  }

  Future<StompClient> initSocket() async {
    // if (client != null) {
    //   client!.deactivate();
    //   client = null; //
    //   print("client disconnected");
    // }
    if (client != null) {
      return client!;
    }
    initPrefs();
    if (client == null) {
      client = StompClient(
        config: StompConfig.sockJS(
          url: 'http://i10a603.p.ssafy.io:8081/websocket',
          webSocketConnectHeaders: {
            // "Petcong-id-token": idToken,
            "transports": ["websocket"],
          },
          onConnect: (StompFrame frame) {
            debugPrint("연결됨");
            client!.subscribe(
              destination: '/queue/$uid',
              headers: {
                "uid": uid!,
              },
              callback: (frame) {
                if (frame.body!.isNotEmpty) {
                  msgArr.add(frame.body!);
                  Map<String, dynamic> response = jsonDecode(frame.body!);

                  String type = response['type'];
                  print('type = $type');
                  Map<String, dynamic> value = response['value'];

                  switch (type) {
                    case 'matched':
                      // 전화 오는 화면으로 이동만. rtc 연결은 요청했던 쪽의 sendOffer로 시작해서 진행됨.
                      targetUid = value['targetUid'];
                      makeCall(targetUid);
                      break;
                    case 'offer':
                      print(
                          "gotOffer============client ====================================${client.hashCode}");
                      value.forEach((key, value) {
                        print('Key: $key, Value: $value');
                      });
                      gotOffer(value['sdp'], value['type']);
                      sendAnswer();
                      break;
                    case 'answer':
                      print(
                          "gotAnswer============client ====================================${client.hashCode}");
                      gotAnswer(value['sdp'], value['type']);
                      break;
                    case 'ice':
                      print(
                          "gotIce============client ====================================${client.hashCode}");
                      gotIce(value['candidate'], value['sdpMid'],
                          value['sdpMLineIndex']);
                  }
                }
              },
            );
          },
          onWebSocketError: (dynamic error) =>
              debugPrint('websocketerror : $error'),
        ),
      );
      await activateSocket(client!);
      await Future.delayed(const Duration(milliseconds: 250));
    }
    print(
        "========================in socketService.initSocket, client.hashCode() = ${client.hashCode}");
    print("SocketService.client 할당 됨");
    return client!;
  }

  void makeCall(String targetUid) async {
    // matched
    // 전화 오는 화면으로
    Get.to(const CallWaiting());
    // 화면 띄워주면서, rtc 연결 시작
    // 화면 띄워주면서, rtc 연결 시작
    await joinRoom();
  }

  Future<void> activateSocket(StompClient client) async {
    client.activate();
  }

  Future<void> onCallPressed(call) async {
    if (call == 'on') {
      await _localRenderer.initialize();
      await _remoteRenderer.initialize();

      Get.to(
        MainVideoCallWidget(
          localRenderer: _localRenderer,
          remoteRenderer: _remoteRenderer,
        ),
      );
    } else {
      // 키
      // // if (_localStream != null) {
      // //   print('here!!!!!!!!!!!!!!!!');
      // //   _localStream!.getTracks().forEach((track) {
      // //     track.stop();
      // //   });
      // // }

      // print(
      //     '??????????????????????????$_localStream, ${localRenderer.srcObject}');
      // print(_localStream?.getAudioTracks());
      // print(_localStream?.getVideoTracks());
      // await _localRenderer.dispose();
      // await _remoteRenderer.dispose();
      // Get.to(const HomePage());
    }
  }

  // Future<void> offCallPressed() async {}

  Future<void> disposeSocket(myuid) async {
    // await initSocket();
    String stringUid = myuid as String;
    try {
      if (client!.isActive == true) {
        debugPrint('Before sending message: Socket is active');
        client!.send(
          destination: '/queue/$stringUid',
          headers: {
            "content-type": "application/json",
            "uid": stringUid,
            "info": "disconnect",
          },
          body: "",
        );
        debugPrint('Message sent to server');
      } else {
        debugPrint('Before sending message: Socket is not active');
      }
      // dispose();
      client!.deactivate();
      debugPrint('연결끔');
      debugPrint('After deactivating: Is client active? ${client?.isActive}');
    } catch (e) {
      debugPrint('Error disposing socket: $e');
    }
  }

  // webRTC

  Future joinRoom() async {
    try {
      if (pc == null) {
        // await initSocket();

        final config = {
          'iceServers': [
            {"url": "stun:stun.l.google.com:19302"},
            {
              "url": "turn:i10a603.p.ssafy.io:3478",
              "username": "ehigh",
              "credential": "1234",
            },
          ],
        };

        final sdpConstraints = {
          'mandatory': {
            'OfferToReceiveAudio': true,
            'OfferToReceiveVideo': true,
          },
          'optional': []
        };

        pc = await createPeerConnection(config, sdpConstraints);
        print('11111111111111[$pc]11111111111111111111');
        pc!.onIceCandidate = (ice) {
          sendIce(ice);
        };

        pc!.onAddStream = (stream) {
          _remoteRenderer.srcObject = stream;
        };
        await Future.delayed(const Duration(seconds: 1));
      } else {
        // return pc;
      }
    } catch (exception) {
      print(exception);
    }

    // client!.send(
    //     // destination: subsPrefix + targetUid.toString(),
    //     destination: subsPrefix + targetUid.toString(),
    //     headers: {
    //       "content-type": "application/json",
    //       "uid": uid!.toString(),
    //       "info": "connect"
    //     },
    //     body: jsonEncode({"type": "joined", "value": ""}));
  }

  Future<void> startCamera() async {
    // await joinRoom();
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    print(pc);
    if (pc != null) {
      print('11111111111');
      final mediaConstraints = {
        'audio': true,
        'video': {'facingMode': 'user'}
      };
      _localStream = await Helper.openCamera(mediaConstraints);

      // 스트림의 트랙(카메라 정보가 들어오는 연결)을 peerConnection(정보를 전송할 connection)에 추가
      _localStream!.getTracks().forEach((track) {
        pc!.addTrack(track, _localStream!);
      });

      // (화면에 띄울) localRenderer의 데이터 소스를 내 localStream으로 설정
      _localRenderer.srcObject = _localStream;
    }
    // 마이크 카메라 끄
    Get.to(
      MainVideoCallWidget(
        localRenderer: _localRenderer,
        remoteRenderer: _remoteRenderer,
      ),
    );
  }

// --- webrtc - 메소드들 ---
  Future sendOffer(String targetUid) async {
    // await initSocket();
    print(
        "========================in sendOffer, client.hashCode() = ${client.hashCode}");

    // await joinRoom(); // 통화 거는쪽은 makeCall()에서
    this.targetUid = targetUid;

    debugPrint('send offer');
    await Future.delayed(const Duration(milliseconds: 1000));

    var offer = await pc!.createOffer();
    pc!.setLocalDescription(offer);
    var map = {"type": "offer", "value": offer.toMap()};
    client!.send(
        destination: '/queue/$targetUid',
        headers: {
          "content-type": "application/json",
          "uid": uid.toString(),
          "info": "connect"
        },
        body: jsonEncode(map));
  }

  Future gotOffer(String sdp, String type) async {
    // await joinRoom(); // 받는 쪽은 gotOffer()에서
    RTCSessionDescription offer = RTCSessionDescription(sdp, type);
    debugPrint('got offer');
    pc!.setRemoteDescription(offer);
  }

  Future sendAnswer() async {
    // client2 = await initSocket();
    print(
        "========================in sendAnswer, client.hashCode() = ${client.hashCode}");

    // await joinRoom();
    debugPrint('send answer');
    var answer = await pc!.createAnswer();
    pc!.setLocalDescription(answer);
    var map = {"type": "answer", "value": answer.toMap()};
    debugPrint("before sendAnswer");
    debugPrint("map = ${jsonEncode(map)}");
    client!.send(
        destination: subsPrefix + targetUid.toString(),
        headers: {
          "content-type": "application/json",
          "uid": uid.toString(),
          "info": "connect"
        },
        body: jsonEncode(map));
  }

  Future gotAnswer(String sdp, String type) async {
    // await joinRoom();
    RTCSessionDescription answer = RTCSessionDescription(sdp, type);
    debugPrint('got answer');
    update();
    pc!.setRemoteDescription(answer);
  }

  Future sendIce(RTCIceCandidate ice) async {
    // client2 = await initSocket();
    print(
        "========================in sendIce, client.hashCode() = ${client.hashCode}");

    // await joinRoom();
    debugPrint("send ice");
    update();
    var map = {"type": "ice", "value": ice.toMap()};
    client!.send(
        destination: subsPrefix + targetUid.toString(),
        headers: {
          "content-type": "application/json",
          "uid": uid.toString(),
          "info": "connect"
        },
        body: jsonEncode(map));
  }

  Future gotIce(String candidate, String sdpMid, int sdpMLineIndex) async {
    // await joinRoom();
    RTCIceCandidate ice = RTCIceCandidate(candidate, sdpMid, sdpMLineIndex);
    debugPrint("got ice");
    pc!.addCandidate(ice);
  }

  RTCVideoRenderer get localRenderer => _localRenderer;
  RTCVideoRenderer get remoteRenderer => _remoteRenderer;
}
