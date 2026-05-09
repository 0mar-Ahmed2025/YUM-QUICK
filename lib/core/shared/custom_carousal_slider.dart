import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousalSlider extends StatelessWidget {
  const CustomCarousalSlider({
    super.key,
    required this.items,
    this.onPageChanged,
    this.onItemTap,
  });

  final List<Widget> items;
  final Function(int)? onPageChanged;
  final Function(int)? onItemTap; // 👈 ضيف دي

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(items.length, (index) {
        return GestureDetector(
          onTap: () {
            if (onItemTap != null) {
              onItemTap!(index); // 👈 ترجعلك ال index
            }
          },
          child: items[index],
        );
      }),
      options: CarouselOptions(
        height: 141,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          if (onPageChanged != null) {
            onPageChanged!(index);
          }
        },
      ),
    );
  }
}
