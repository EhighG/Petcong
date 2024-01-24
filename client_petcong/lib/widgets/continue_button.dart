import 'package:flutter/material.dart';
import 'package:petcong/constants/style.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required this.isFilled,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);

  final bool isFilled;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: isFilled
            ? const LinearGradient(
                colors: [
                  MyColor.myColor4,
                  MyColor.myColor3,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.grey,
                ],
              ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: isFilled
            ? [
                const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.57),
                  blurRadius: 5,
                )
              ]
            : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent.withOpacity(0.38),
          disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
          shadowColor: Colors.transparent,
          minimumSize: const Size(500.0, 30.0),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 6,
            bottom: 6,
          ),
          child: Text(
            buttonText, // 이전에는 'Continue'였는데, 이제는 buttonText를 사용합니다.
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
