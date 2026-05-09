import 'package:flutter/material.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/features/products/cubits/search/search_cubit.dart';
import 'package:yum_quick/features/products/cubits/search/view/search_view.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({super.key});
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 26,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onTap: () => MyNavigator.goto(context, SearchScreen()),
              onChanged: (value) {
                SearchCubit.get(context).search(value);
              },
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Color(0xff676767)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomSvgWrapper(
                path: 'assets/icons/shoping_car_icon.svg',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
