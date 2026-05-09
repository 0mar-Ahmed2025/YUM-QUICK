import 'package:flutter/material.dart';

class CustomBTN extends StatelessWidget {
  final String text;
  final Color? backColor;
  final Color? frontColor;

  final void Function()? onPressed;
  const CustomBTN({
    super.key,
    required this.text,
    required this.onPressed,
    this.backColor,
    this.frontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 45,
        width: 207,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backColor,
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: frontColor, fontSize: 24)),
        ),
      ),
    );
  }
}
