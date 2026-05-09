import 'package:flutter/material.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/features/get_start/models/on_boarding_model.dart';
import 'package:yum_quick/features/get_start/widgets/on_boarding_widget.dart';
import 'package:yum_quick/features/get_start/views/welcome_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final List<OnboardingModel> _items = [
    OnboardingModel(
      image: 'assets/images/on_boarding_a.png',
      icon: "assets/icons/on_boarding_a_icon.svg",
      title: "Order for Food",
    ),
    OnboardingModel(
      image: "assets/images/on_boarding_b.png",
      icon: "assets/icons/on_boarding_b_icon.svg",
      title: "Easy Payment",
    ),
    OnboardingModel(
      image: "assets/images/on_boarding_c.png",
      icon: "assets/icons/on_boarding_c_icon.svg",
      title: "Fast Delivery",
    ),
  ];
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          final bool isLastPage = index == _items.length - 1;

          return OnboardingWidget(
            imagePath: item.image,
            iconPath: item.icon,
            title: item.title,
            description: item.description,
            buttonText: isLastPage ? "Get Started" : "Next",
            currentIndex: index,
            totalPages: _items.length,
            onBtnPressed: () {
              if (isLastPage) {
                MyNavigator.gotoWithAnimation(context, const WelcomeView());
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                );
              }
            },
          );
        },
      ),
    );
  }
}
