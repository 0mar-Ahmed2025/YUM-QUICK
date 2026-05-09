import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_quick/core/helper/app_pop_up.dart';
import 'package:yum_quick/core/helper/app_validator.dart';
import 'package:yum_quick/core/shared/custom_btn.dart';
import 'package:yum_quick/core/shared/custom_text_field.dart';
import 'package:yum_quick/core/shared/custom_views_style.dart';
import 'package:yum_quick/core/shared/image_manager.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/features/auth/data/models/user_model.dart';
import 'package:yum_quick/features/users/cubits/updat_user_profile/update_user_profile_cubit.dart';
import 'package:yum_quick/features/users/cubits/updat_user_profile/update_user_profile_state.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit(userModel),
      child: CustomViewsStyle(
        header: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            "My Profile",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileErrorState) {
                SnackBarPopUp().show(
                  context: context,
                  message: state.error,
                  state: PopUpState.error,
                );
              } else if (state is UpdateProfileSuccessState) {
                SnackBarPopUp().show(
                  context: context,
                  message: 'Profile Updateed successfully',
                  state: PopUpState.success,
                );
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              var cubit = UpdateProfileCubit.get(context);
              return Center(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: ImageManager(
                              unselectedImageBuilder: Image.asset(
                                "assets/images/profile_photo.png",
                                height: 127,
                                width: 127,
                                fit: BoxFit.cover,
                              ),
                              networkImageBuilder: userModel.imagePath == null
                                  ? null
                                  : Image.network(
                                      userModel.imagePath!,
                                      height: 127,
                                      width: 127,
                                      fit: BoxFit.cover,
                                    ),
                              selectedImageBuilder: (XFile path) {
                                cubit.image = path;
                                return Image.file(
                                  File(path.path),
                                  height: 127,
                                  width: 127,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => cubit.pickImage(),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      CustomTextField(
                        controller: cubit.userName,
                        hintText: 'Enter Your Name',
                        validator: AppValidator.validateRequired,
                        textFieldName: 'Full Name',
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: cubit.phone,
                        hintText: 'Enter Phone Number',
                        textFieldName: "Phone Number",
                      ),
                      SizedBox(height: 15),
                      state is UpdateProfileLoadingState
                          ? CircularProgressIndicator()
                          : CustomBTN(
                              frontColor: AppColors.primary,
                              backColor: AppColors.orange,
                              text: 'Update Profile',
                              onPressed: cubit.onUpdatePorfilePressed,
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> onUpdateTaskPressed() async {
    // if(formKey.currentState?.validate() == true){
    //   var result = await APIHelper.updateTask(
    //     id: widget.taskModel.id??0,
    //       title: title.text,
    //       description: desc.text,
    //       imagePath: imagePath
    //   );
    //   result.fold(
    //           (errorMsg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(errorMsg, style: TextStyle(color: AppColors.white),),
    //         backgroundColor: AppColors.error,
    //       )),
    //           (successMsg){
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text(successMsg, style: TextStyle(color: AppColors.white),),
    //           backgroundColor: AppColors.primary,
    //         ));
    //         Navigator.pop(context);
    //       }
    //   );
    // }
  }
}
