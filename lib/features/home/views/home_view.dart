// ignore_for_file: use_build_context_synchronously, strict_top_level_inference
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/core/shared/custom_carousal_slider.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/features/home/views/widgets/best_seller/best_seller_item_builder.dart';
import 'package:yum_quick/features/home/views/widgets/item/item_builder.dart';
import 'package:yum_quick/features/home/views/widgets/item/item_view.dart';
import 'package:yum_quick/features/home/views/widgets/search_text_field.dart';
import 'package:yum_quick/features/home/views/widgets/slider_item_builder.dart';
import 'package:yum_quick/features/products/cubits/best_seller/best_seller_cubit.dart';
import 'package:yum_quick/features/products/cubits/best_seller/best_seller_state.dart';
import 'package:yum_quick/features/products/cubits/top_rated/top_rated_cubit.dart';
import 'package:yum_quick/features/products/cubits/top_rated/top_rated_state.dart';
import 'package:yum_quick/features/products/views/best_seller_view.dart';
import 'package:yum_quick/features/sliders/cubits/get_slider/get_slider_cubit.dart';
import 'package:yum_quick/features/sliders/cubits/get_slider/get_slider_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetSliderCubit()..getSliders()),
        BlocProvider(create: (context) => TopRatedCubit()..getTopRated()),
        BlocProvider(create: (context) => BestSellerCubit()..getBestSeller()),
      ],
      child: Container(
        color: AppColors.primary,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primary,
            body: Column(
              children: [
                const _HomeHeader(),
                Expanded(child: _HomeContentBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchTextField(),
          const SizedBox(height: 8),

          Text(
            "Good Morning",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          Text(
            "Rise and shine! It's breakfast time",
            style: TextStyle(
              fontSize: 13,
              color: AppColors.orange,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeContentBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const _SectionHeader(title: 'Best Seller'),
          _HomeBestSellerSection(),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),

          // الجزء الخاص بالـ Slider مع الـ BlocBuilder
          const _HomeSliderSection(),

          const SliverToBoxAdapter(child: SizedBox(height: 0)),
          const _SectionHeader(title: 'Recommend', hasViewAll: false),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          _HomeRecommendSection(),
          // _HomeRecommendSection(),
        ],
      ),
    );
  }
}

class _HomeBestSellerSection extends StatelessWidget {
  const _HomeBestSellerSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoadinglState) {
          return const SliverToBoxAdapter(child: SizedBox());
        } else if (state is BestSellerSuccessState) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: state.bestSeller.length,
                itemBuilder: (context, index) => BestSellerItemBuilder(
                  image: state.bestSeller[index].imagePath!,
                ),
              ),
            ),
          );
        } else if (state is BestSellerErrorState) {
          return SliverToBoxAdapter(child: Text('Error: ${state.error}'));
        }
        return SliverToBoxAdapter(
          child: Container(height: 20, width: 20, color: Colors.red),
        );
      },
    );
  }
}

class _HomeSliderSection extends StatelessWidget {
  const _HomeSliderSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSliderCubit, GetSliderState>(
      builder: (context, state) {
        if (state is GetSliderLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is GetSliderSuccessState) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                CustomCarousalSlider(
                  items: List.generate(
                    state.sliders.length, // استخدم طول القائمة الحقيقي
                    (index) => SliderItemBuilder(
                      imageUrl: state.sliders[index].imagePath!,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                DotsIndicator(
                  // لازم عدد النقط يساوي عدد الصور اللي جت فعلاً
                  dotsCount: state.sliders.isNotEmpty
                      ? state.sliders.length
                      : 1,
                  decorator: DotsDecorator(activeColor: AppColors.orange),
                ),
              ],
            ),
          );
        } else if (state is GetSliderErrorState) {
          return SliverToBoxAdapter(child: Text('Error: ${state.error}'));
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}

class _HomeRecommendSection extends StatelessWidget {
  const _HomeRecommendSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedState>(
      builder: (context, state) {
        if (state is TopRatedLoadinglState) {
          return const SliverToBoxAdapter(child: SizedBox());
        } else if (state is TopRatedSuccessState) {
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => ItemBuilder(
                image: state.topRated[index].imagePath!,
                onTap: () => MyNavigator.goto(context, ItemView(id: index)),
              ),

              childCount: state.topRated.length,
            ),
          );
        } else if (state is TopRatedErrorState) {
          return SliverToBoxAdapter(child: Text('Error: ${state.error}'));
        }
        return SliverToBoxAdapter(
          child: Container(height: 50, width: 50, color: Colors.red),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool hasViewAll;
  const _SectionHeader({required this.title, this.hasViewAll = true});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: AppFontWeight.medium),
          ),
          const Spacer(),
          if (hasViewAll) ...[
            TextButton(
              onPressed: () => MyNavigator.goto(context, BestSellerView()),
              child: Text(
                'View All',
                style: TextStyle(color: AppColors.orange),
              ),
            ),
            CustomSvgWrapper(path: 'assets/icons/Next icon Arrow.svg'),
          ],
        ],
      ),
    );
  }
}
