import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/core/shared/custom_go_to_btn.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/shared/custom_views_style.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/features/auth/views/login_view.dart';
import 'package:yum_quick/features/home/views/settings_vew.dart';
import 'package:yum_quick/features/orders/views/orders_view.dart';
import 'package:yum_quick/features/products/views/favorite_view.dart';
import 'package:yum_quick/features/users/cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:yum_quick/features/users/cubits/get_user_data_cubit/get_user_data_states.dart';
import 'package:yum_quick/features/users/views/my_profile_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserDataCubit()..getUserDataPressed(),
      child: BlocBuilder<GetUserDataCubit, GetUserDataState>(
        builder: (context, state) {
          if (state is GetUserDataSuccessState) {
            return CustomViewsStyle(
              header: ListTile(
                title: Text(
                  state.user.username!,
                  style: TextStyle(fontSize: 28),
                ),
                subtitle: Text(
                  state.user.email!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        spreadRadius: 0,
                        color: AppColors.black.withAlpha(60),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: state.user.imagePath == null
                        ? AssetImage('assets/images/profile_photo.png')
                        : NetworkImage(state.user.imagePath!),
                  ),
                ),
              ),
              body: Column(
                children: [
                  SizedBox(height: 30),
                  CustomGoToBtn(
                    leading: CustomSvgWrapper(
                      path: "assets/icons/User Icon.svg",
                      color: AppColors.orange,
                    ),
                    trailing: CustomSvgWrapper(
                      path: "assets/icons/Next icon Arrow.svg",
                      color: AppColors.orange,
                    ),
                    text: 'My Profile',
                    onPressed: () async {
                      final bool? isUpdated = await MyNavigator.goto(
                        context,
                        MyProfileView(userModel: state.user),
                        type: NavigatorType.push,
                      );
                      if (isUpdated == true && context.mounted) {
                        GetUserDataCubit.get(context).getUserDataPressed();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomGoToBtn(
                    leading: CustomSvgWrapper(
                      path: "assets/icons/lock_icon.svg",
                      color: AppColors.orange,
                    ),
                    trailing: CustomSvgWrapper(
                      path: "assets/icons/Next icon Arrow.svg",
                      color: AppColors.orange,
                    ),
                    text: 'My Orders',
                    onPressed: () => MyNavigator.goto(
                      context,
                      OrdersView(),
                      type: NavigatorType.push,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomGoToBtn(
                    leading: CustomSvgWrapper(
                      path: "assets/icons/heart.svg",
                      // color: AppColors.orange,
                    ),
                    trailing: CustomSvgWrapper(
                      path: "assets/icons/Next icon Arrow.svg",
                      color: AppColors.orange,
                    ),
                    text: 'My Favorites',
                    onPressed: () => MyNavigator.goto(
                      context,
                      FavoriteView(),
                      type: NavigatorType.push,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomGoToBtn(
                    leading: CustomSvgWrapper(
                      path: "assets/icons/seetings_icon.svg",
                      color: AppColors.orange,
                    ),
                    trailing: CustomSvgWrapper(
                      path: "assets/icons/Next icon Arrow.svg",
                      color: AppColors.orange,
                    ),
                    text: 'Settings',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageSelector(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(color: AppColors.primary),
                  CustomGoToBtn(
                    leading: CustomSvgWrapper(
                      path: "assets/icons/Log Out icon.svg",
                      color: AppColors.orange,
                    ),
                    trailing: CustomSvgWrapper(
                      path: "assets/icons/Next icon Arrow.svg",
                      color: AppColors.orange,
                    ),
                    text: 'Log Out',
                    onPressed: () => MyNavigator.goto(
                      context,
                      LoginView(),
                      type: NavigatorType.pushAndRemoveUntil,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            );
          }
        },
      ),
    );
  }
}
