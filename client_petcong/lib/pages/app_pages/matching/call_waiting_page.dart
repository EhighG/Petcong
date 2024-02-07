import 'package:flutter/material.dart';
import 'package:petcong/constants/style.dart';
import 'package:petcong/services/socket_service.dart';

class CallWaiting extends StatelessWidget {
  const CallWaiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       SocketService().startCamera();
      //     },
      //     child: const Text('call'),
      //   ),
      // ),
      body: Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/src/fatdog-dog-unscreen.gif',
            )),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / 4,
            child: FloatingActionButton(
              heroTag: 'call_button',
              onPressed: () {
                SocketService().startCamera();
              },
              shape: const CircleBorder(eccentricity: 0),
              backgroundColor: MyColor.myColor1,
              child: const Icon(Icons.call),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width / 5,
            child: FloatingActionButton(
              heroTag: 'call_reject_button',
              onPressed: () {},
              shape: const CircleBorder(eccentricity: 0),
              backgroundColor: MyColor.petCongColor4.withOpacity(0.8),
              child: const Icon(Icons.call_end),
            ),
          ),
        ],
      ),
    );
  }
}
