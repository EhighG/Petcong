import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcong/models/choice_res.dart';
import 'package:petcong/pages/app_pages/matching/call_waiting_page.dart';
import 'package:petcong/services/socket_service.dart';
import 'package:petcong/services/matching_service.dart';
import 'package:petcong/widgets/card_overlay.dart';
import 'package:petcong/widgets/matching_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:swipable_stack/swipable_stack.dart';

const _images = [
  'assets/src/dog.jpg',
  'assets/src/test_1.jpg',
  'assets/src/test_5.jpg',
];

const _nicknames = ['종유', '빌리', '숙희'];
const _petNames = ['초코', '둘리', '세르시'];
const _humanAges = [21, 22, 23];
const _petAges = [1, 2, 3];

class MainMatchingPage extends StatefulWidget {
  final SocketService?
      socketService; // HomePage -> _MainMatchingPageState로의 전달을 위함
  const MainMatchingPage({Key? key, this.socketService}) : super(key: key);

  @override
  State<MainMatchingPage> createState() => _MainMatchingPageState();
}

class _MainMatchingPageState extends State<MainMatchingPage> {
  late final SwipableStackController _controller;

  // late Function onCallPressed;
  late SocketService socketService;
  final MatchingService matchingService = MatchingService();
  late StompClient client;
  String? uid;

  void _listenController() {
    setState(() {});
  }

  Future<void> initPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      uid = prefs.getString('uid');
      print(uid);
    } catch (e) {
      debugPrint('Error retrieving values from SharedPreferences: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    socketService = widget
        .socketService!; // 얘를 생성하는 쪽(HomePage)의 socketService를 전달받아야 함. 전달이 제대로 안 됐다면 에러 나게 설정
    _controller = SwipableStackController()..addListener(_listenController);
    initClient();
    initPrefs();
  }

  void initClient() async {
    client = await socketService
        .initSocket(); // socketService의 client를 static으로 설정했으므로, socketService 인스턴스가 여러개라도 얘는 기존에 있던 client를 받는다.
  }

  Future<void> initPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      uid = prefs.getString('uid');
      print(uid);
    } catch (e) {
      debugPrint('Error retrieving values from SharedPreferences: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SwipableStack(
                  detectableSwipeDirections: const {
                    SwipeDirection.right,
                    SwipeDirection.left,
                    SwipeDirection.up,
                    SwipeDirection.down,
                  },
                  controller: _controller,
                  stackClipBehaviour: Clip.none,
                  onSwipeCompleted: _onSwipe,
                  horizontalSwipeThreshold: 0.15,
                  verticalSwipeThreshold: 0.15,
                  builder: (context, properties) {
                    final itemIndex = properties.index % _images.length;
                    return Stack(
                      children: [
                        MatchingCard(
                          nickname: _nicknames[itemIndex],
                          age: _humanAges[itemIndex],
                          petName: _petNames[itemIndex],
                          petAge: _petAges[itemIndex],
                          description:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non fringilla lorem. Integer diam nisi, congue at mauris tincidunt, finibus vulputate sapien.',
                          profileImages: _images[itemIndex],
                        ),
                        if (properties.stackIndex == 0 &&
                            properties.direction != null)
                          CardOverlay(
                            swipeProgress: properties.swipeProgress,
                            direction: properties.direction!,
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // 매칭페이지의 call버튼 -> onLike() -> makeCall()을 통해 통화대기화면 이동까지만.
        heroTag: 'call',
        onPressed: () {
          // socketService.onCallPressed('on');
          // Get.to(const CallWaiting());
          // SocketService().joinRoom();
          if (uid == '4GtzqrsSDBVSC1FkOWXXJ2i7CfA3') {
            onLike('Z8RNqMBdk6SuBAuA9i0shV19QSR2'); // 패드
          } else {
            onLike('4GtzqrsSDBVSC1FkOWXXJ2i7CfA3'); // 영주폰
          }
        },
        label: const Text('call'),
        icon: const Icon(Icons.call),
      ),
    );
  }

  void _onSwipe(int index, SwipeDirection direction) {
    if (kDebugMode) {
      print('$index, $direction');
    }
  }

  /// targetId = int

  Future<void> onLike(String targetUid) async {
    ChoiceRes? choiceRes;
    try {
      print(targetUid);
      choiceRes = await matchingService.postMatching(targetUid);
    } catch (exception) {
      print("exception = $exception");
      print("alert: 잘못된 요청");
      return;
    }
    if (choiceRes == null) {
      print("pending처리됨");
      return;
    }
    // when matched
    await socketService.makeCall(choiceRes.targetUid!); // callWaitingPage로 이동만.
  }
}
