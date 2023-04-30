import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  const MyButtons({
    super.key,
    required this.color,
    required this.buttonText,
    required this.textColor,
    this.buttonTapped,
  });
  final Color? color;
  final String buttonText;
  final Color? textColor;
  final void Function()? buttonTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
