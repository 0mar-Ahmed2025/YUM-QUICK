import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/features/categories/cubit/categories_state.dart';
import 'package:yum_quick/features/categories/cubit/categoris_cubit.dart';
import 'package:yum_quick/features/categories/data/repo/categories_repo.dart';
import 'package:yum_quick/core/shared/custom_views_style.dart';
import 'package:yum_quick/features/home/views/widgets/search_text_field.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(CategoriesRepo())..getCategories(),
      child: CustomViewsStyle(
        header: Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: SearchTextField(),
        ),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            var cubit = CategoriesCubit.get(context);
            if (state is CategoriesLoading) {
              return CircularProgressIndicator();
            } else if (state is CategoriesError) {
              return Text(state.error);
            } else if (cubit.categories != null) {
              return Column(
                children: [
                  // Horizontal List of Categories
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 20),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => cubit.onCategoryTapped(index),
                        child: Column(
                          children: [
                            Container(
                              height: 75,
                              width: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    cubit.categories![index].imagePath!,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  width: 2,
                                  color: cubit.currentIndex == index
                                      ? AppColors.orange
                                      : Colors.grey,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                            ),

                            SizedBox(height: 10),
                            Text(
                              cubit.categories![index].title ?? '',
                              style: TextStyle(
                                color: cubit.currentIndex == index
                                    ? AppColors.orange
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                      itemCount: cubit.categories!.length,
                    ),
                  ),
                  Divider(color: AppColors.orange),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => MenuItemBuilder(
                        image:
                            cubit
                                .categories![cubit.currentIndex]
                                .products![index]
                                .imagePath ??
                            '',
                        name:
                            cubit
                                .categories![cubit.currentIndex]
                                .products![index]
                                .name ??
                            '',
                        description:
                            cubit
                                .categories![cubit.currentIndex]
                                .products![index]
                                .description ??
                            '',
                        price:
                            cubit
                                .categories![cubit.currentIndex]
                                .products![index]
                                .price ??
                            0,
                        rate:
                            cubit
                                .categories![cubit.currentIndex]
                                .products![index]
                                .rating ??
                            0,
                      ),

                      itemCount: cubit
                          .categories![cubit.currentIndex]
                          .products!
                          .length,
                    ),
                  ),
                ],
              );
            } else {
              return Text('data');
            }
          },
        ),
      ),
    );
  }
}

class MenuItemBuilder extends StatelessWidget {
  const MenuItemBuilder({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.rate,
    this.onTap,
  });

  final String image;
  final String name;
  final String description;
  final double price;
  final double rate;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              SizedBox(width: 25),
              RatingBadge(rating: rate),
              Spacer(),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          Text(
            description,
            style: TextStyle(fontWeight: AppFontWeight.extraLight),
          ),

          Divider(color: Color(0xffFFD8C7)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const CustomSvgWrapper(path: "assets/icons/star_icon.svg", width: 12),
        ],
      ),
    );
  }
}
