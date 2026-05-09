import 'package:flutter/material.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/core/shared/custom_btn.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/features/auth/views/login_view.dart';
import 'package:yum_quick/features/auth/views/register_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE95322),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgWrapper(
              path: 'assets/images/logo.svg',
              color: Color(0xffF5CB58),
            ),
            SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'YUM',
                  style: TextStyle(
                    color: Color(0xffF5CB58),
                    fontSize: 34,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                Text(
                  'QUICK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              textAlign: TextAlign.center,
              'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod.',
              style: TextStyle(
                color: Color(0xffF8F8F8),
                fontWeight: AppFontWeight.medium,
              ),
            ),
            SizedBox(height: 43),
            CustomBTN(
              text: 'Log In',
              onPressed: () => MyNavigator.goto(context, LoginView()),
              backColor: AppColors.primary,
              frontColor: AppColors.orange,
            ),
            SizedBox(height: 5),
            CustomBTN(
              text: 'Sign Up',
              onPressed: () => MyNavigator.goto(context, RegisterView()),
              backColor: AppColors.lightYellow,
              frontColor: AppColors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
