import 'package:flutter/material.dart';

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    super.key,
    required this.image,
    this.height = 140,
    this.width = 160,
    this.onTap,
  });

  final String image;
  final double? height;
  final double? width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10, bottom: 10),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(image)),
        ),
      ),
    );
  }
}
