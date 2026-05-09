import 'package:flutter/material.dart';

class SliderItemBuilder extends StatelessWidget {
  const SliderItemBuilder({super.key, required this.imageUrl, this.onTap});

  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
