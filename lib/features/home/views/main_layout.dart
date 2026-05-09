import 'package:flutter/material.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/features/categories/views/categories_view.dart';
import 'package:yum_quick/features/home/views/home_view.dart';
import 'package:yum_quick/features/users/views/profile_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> screens = [HomeView(), CategoriesView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      // body: screens[currentIndex],
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: AppColors.primary),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.white,
        backgroundColor: AppColors.orange,
        // elevation: 0,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: CustomSvgWrapper(path: "assets/icons/home_icon.svg"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgWrapper(path: "assets/icons/menue_icon.svg"),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgWrapper(path: "assets/icons/User Icon.svg"),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
