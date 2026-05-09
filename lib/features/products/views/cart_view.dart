// ignore_for_file: use_build_context_synchronously, strict_top_level_inference, use_super_parameters, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:yum_quick/core/shared/custom_btn.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. وضع الـ Providers في أعلى الشجرة
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                    child: Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: CustomSvgWrapper(
                                path: "assets/icons/Less Icon.svg",
                              ),
                            ),
                            Text(
                              'counter',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: AppFontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: CustomSvgWrapper(
                                path: "assets/icons/Add to car Icon.svg",
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Color(0xffFFD8C7)),

                        const SizedBox(height: 60),

                        Center(
                          child: CustomBTN(
                            text: 'Check Out',
                            onPressed: () {},
                            backColor: AppColors.lightYellow,
                            frontColor: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ), // الجزء القابل للـ Scroll
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const CustomSvgWrapper(path: "assets/icons/star_icon.svg", width: 12),
        ],
      ),
    );
  }
}
