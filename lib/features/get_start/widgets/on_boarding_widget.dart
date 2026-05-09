import 'package:flutter/material.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/features/get_start/widgets/skip_btn.dart';

class OnboardingWidget extends StatelessWidget {
  final String imagePath;
  final String iconPath;
  final String title;
  final String description;
  final String buttonText;
  final void Function() onBtnPressed;
  final int currentIndex;
  final int totalPages;

  const OnboardingWidget({
    super.key,
    required this.imagePath,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.currentIndex,
    required this.totalPages,
    required this.onBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = const Color(0xFFE55A28);

    return Container(
      color: Color(0xffF5CB58),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.90,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),

              Positioned(top: 10, right: 20, child: SkipBtn()),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 24,
                    right: 24,
                    bottom: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: IconButton(
                          onPressed: null,
                          icon: CustomSvgWrapper(path: iconPath),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // الوصف
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          totalPages,
                          (index) => _buildDot(index, primaryColor),
                        ),
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: 160,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: onBtnPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index, Color primaryColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: currentIndex == index ? 24 : 16,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentIndex == index
            ? primaryColor
            : primaryColor.withValues(alpha: 0.2),
      ),
    );
  }
}
