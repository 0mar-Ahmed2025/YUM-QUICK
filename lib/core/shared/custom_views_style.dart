import 'package:flutter/material.dart';
import 'package:yum_quick/core/utils/app_colors.dart';

class CustomViewsStyle extends StatelessWidget {
  const CustomViewsStyle({super.key, this.header, this.body});

  final Widget? header;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: header,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
