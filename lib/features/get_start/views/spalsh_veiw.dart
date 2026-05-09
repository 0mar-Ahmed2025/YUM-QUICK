// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/features/get_start/views/on_boarding.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _logoSize = 80.0;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimationAndNavigate();
  }

  void _startAnimationAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _logoSize = 40.0;
        _opacity = 1.0;
      });
    }

    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      MyNavigator.gotoWithAnimation(context, const OnBoardingView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: _opacity,
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.elasticOut,
                width: _logoSize * 6,
                height: _logoSize * 4,
                child: const CustomSvgWrapper(path: "assets/images/logo.svg"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: _opacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "YUM",
                  style: TextStyle(
                    color: AppColors.orange,
                    fontSize: _logoSize,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "QUICK",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: _logoSize,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
