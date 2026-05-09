// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_quick/core/shared/custom_views_style.dart';

class SettingsView extends GetxController {
  final language = 'en'.obs;

  void changeLanguage(String lang) {
    language.value = lang;
    Get.updateLocale(Locale(lang));
  }
}

const Color _darkBrownText = Color(0xFF2D1414);
const Color _deepRedOrangeActive = Color(0xFFD84315);
const Color _lightCreamInactive = Color(0xFFF5E0C3);
const Color _veryLightBackground = Color(0xFFFFFDF8);

class LanguageSelector extends StatelessWidget {
  LanguageSelector({super.key});

  final SettingsView _languageController = Get.put(SettingsView());

  @override
  Widget build(BuildContext context) {
    return CustomViewsStyle(
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          "Settings",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Language',
              style: TextStyle(
                color: _darkBrownText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            Obx(() => _buildLanguageSwitch()),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSwitch() {
    bool isEnActive = _languageController.language.value == 'en';
    bool isArActive = _languageController.language.value == 'ar';

    return Container(
      width: 130,
      height: 30,
      decoration: BoxDecoration(
        color: _lightCreamInactive,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          children: [
            // زر AR
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _languageController.changeLanguage('ar');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isArActive
                        ? _deepRedOrangeActive
                        : _lightCreamInactive,
                  ),
                  child: Center(
                    child: Text(
                      'AR',
                      style: TextStyle(
                        color: isArActive ? Colors.white : _darkBrownText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // زر EN
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _languageController.changeLanguage('en');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isEnActive
                        ? _deepRedOrangeActive
                        : _lightCreamInactive,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'EN',
                      style: TextStyle(
                        color: isEnActive ? Colors.white : _darkBrownText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
