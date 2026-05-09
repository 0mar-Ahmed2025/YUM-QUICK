import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/features/categories/views/categories_view.dart';
import 'package:yum_quick/features/products/cubits/get_products/get_products_cubit.dart';
import 'package:yum_quick/features/products/cubits/get_products/get_products_state.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductsCubit()..getProducts(),
      child: Container(
        color: AppColors.primary,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primary,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 20,
                  ),
                  child: Text(
                    'Best Seller',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: AppFontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
                        children: [
                          Divider(color: Color(0xffFFD8C7)),
                          MenuItemsSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItemsSection extends StatelessWidget {
  const MenuItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsLoadinglState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetProductsSuccessState) {
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: state.products.length,
            itemBuilder: (context, index) =>
                state.products[index].bestSeller != 0
                ? MenuItemBuilder(
                    image: state.products[index].imagePath!,
                    name: state.products[index].name!,
                    description: state.products[index].description!,
                    price: state.products[index].price!,
                    rate: state.products[index].rating!,
                  )
                : Container(),
          );
        } else if (state is GetProductsErrorState) {
          return Text('Error: ${state.error}');
        }
        return Container(height: 20, width: 20, color: Colors.red);
      },
    );
  }
}
