// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';

enum NavigatorType { push, pushReplacement, pushAndRemoveUntil, pop }

abstract class MyNavigator {
  static goto(
    BuildContext? context,
    Widget screen, {
    NavigatorType type = NavigatorType.push,
  }) {
    var pageRoute = MaterialPageRoute(builder: (_) => screen);
    switch (type) {
      case NavigatorType.pop:
        return Navigator.pop(context!, pageRoute);
      case NavigatorType.push:
        return Navigator.push(context!, pageRoute);
      case NavigatorType.pushReplacement:
        return Navigator.pushReplacement(context!, pageRoute);
      case NavigatorType.pushAndRemoveUntil:
        return Navigator.pushAndRemoveUntil(
          context!,
          pageRoute,
          (route) => false,
        );
    }
  }

  static void gotoWithAnimation(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // بنحدد نوع الحركة هنا (مثلاً Slide من اليمين للشمال)
          const begin = Offset(1.0, 0.0); // بيبدأ من بره الشاشة يمين
          const end = Offset.zero; // بيستقر في مكانه الطبيعي
          const curve = Curves.easeOutSine; // شكل الزحلقة

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500), // سرعة النقلة
      ),
    );
  }
}
