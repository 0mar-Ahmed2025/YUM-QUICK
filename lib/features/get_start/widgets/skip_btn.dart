import 'package:flutter/material.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/features/get_start/views/welcome_view.dart';

class SkipBtn extends StatelessWidget {
  const SkipBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyNavigator.goto(context, WelcomeView()),
      child: Row(
        children: [
          Text(
            'Skip',
            style: TextStyle(
              color: const Color(0xFFE55A28),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_forward_ios,
            color: const Color(0xFFE55A28),
            size: 14,
          ),
        ],
      ),
    );
  }
}
