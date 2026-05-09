import 'package:flutter/material.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';

class CustomGoToBtn extends StatelessWidget {
  const CustomGoToBtn({
    super.key,
    required this.onPressed,
    required this.text,
    this.leading,
    this.trailing,
  });

  final void Function()? onPressed;
  final String text;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 63,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: onPressed,
        title: Text(text, style: TextStyle(fontWeight: AppFontWeight.medium)),
        leading: leading,
        trailing: trailing,
      ),
    );
  }
}
