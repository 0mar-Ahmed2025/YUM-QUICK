import 'package:flutter/material.dart';
import 'package:yum_quick/features/home/views/widgets/best_seller/best_seller_item_builder.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  final List<BestSellerItemBuilder> categories = const [
    BestSellerItemBuilder(image: 'assets/images/best 1.png'),
    BestSellerItemBuilder(image: 'assets/images/best 2.png'),
    BestSellerItemBuilder(image: 'assets/images/best 3.png'),
    BestSellerItemBuilder(image: 'assets/images/best 4.png'),
    BestSellerItemBuilder(image: 'assets/images/best 2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => categories[index],
      ),
    );
  }
}
