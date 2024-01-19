import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcong/controller/user_controller.dart';
import 'package:petcong/pages/homepage.dart';
import 'package:petcong/style.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColor.myColor4.withOpacity(0.5), // 우측 상단 색상
              MyColor.myColor2.withOpacity(0.4), // 좌측 상단 색상
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: _handleGoogleSignIn,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // 그림자의 색상 및 투명도
                    spreadRadius: 2, // 그림자의 퍼짐 정도
                    blurRadius: 4, // 그림자의 흐림 정도
                    offset: const Offset(0, 2), // 그림자의 위치 (가로, 세로)
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/src/google_logo.png',
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleGoogleSignIn() async {
    if (true) {
      try {
        User? user = await FirebaseAuth.instance.authStateChanges().first;
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          if (Platform.isAndroid) {
            await UserController.loginWithGoogle();
          } else {
            GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
            await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } catch (error) {
        print(error);
      }
    }
  }
}
