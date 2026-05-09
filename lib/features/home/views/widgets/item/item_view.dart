// ignore_for_file: use_build_context_synchronously, strict_top_level_inference, use_super_parameters, unused_element_parameter, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/shared/custom_btn.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/features/products/cubits/get_products/get_products_cubit.dart';
import 'package:yum_quick/features/products/cubits/get_products/get_products_state.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.id});

  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductsCubit()..getProducts(),
      child: BlocBuilder<GetProductsCubit, GetProductsState>(
        builder: (context, state) {
          if (state is GetProductsLoadinglState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetProductsSuccessState) {
            return Container(
              color: AppColors.primary,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.primary,
                  body: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: CustomSvgWrapper(
                                  path: "assets/icons/arrow_back_icon.svg",
                                  width: 15,
                                ),
                              ),
                              Text(
                                state.products[id].name!,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: AppColors.black,
                                  fontWeight: AppFontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.orange,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: CustomSvgWrapper(
                                  path: "assets/icons/favorite_icon.svg",
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: RatingBadge(
                              rating: state.products[id].rating!,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),

                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.products[id].imagePath!,
                                      ),

                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${state.products[id].price!.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: AppColors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: CustomSvgWrapper(
                                        path: "assets/icons/Less Icon.svg",
                                      ),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: AppFontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: CustomSvgWrapper(
                                        path:
                                            "assets/icons/Add to car Icon.svg",
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: Color(0xffFFD8C7)),

                                Text(state.products[id].description!),
                                const SizedBox(height: 60),
                                Center(
                                  child: CustomBTN(
                                    text: 'Add To Cart',

                                    onPressed: () {},
                                    backColor: AppColors.orange,
                                    frontColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is GetProductsErrorState) {
            return Center(child: Text(state.error));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
              fontSize: 18,
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
