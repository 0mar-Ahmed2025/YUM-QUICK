import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yum_quick/core/helper/app_pop_up.dart';
import 'package:yum_quick/core/helper/app_validator.dart';
import 'package:yum_quick/core/shared/custom_btn.dart';
import 'package:yum_quick/core/shared/custom_text_field.dart';
import 'package:yum_quick/features/users/cubits/change_pasword/change_password_cubit.dart';
import 'package:yum_quick/features/users/cubits/change_pasword/change_password_state.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is ChangePasswordSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message: 'Password Changed successfully',
                state: PopUpState.success,
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            var cubit = ChangePasswordCubit.get(context);
            return Form(
              key: cubit.formKey,

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    Padding(
                      padding: REdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomTextField(
                            textFieldName: 'Full Name',
                            controller: cubit.currentPassword,
                            hintText: 'Enter Your Current Password',
                            lableText: 'Old Password',
                            validator: AppValidator.validateRequired,
                          ),
                          SizedBox(height: 20.h),

                          CustomTextField(
                            textFieldName: 'Phone Numer',
                            controller: cubit.newPassword,
                            hintText: 'Enter New Password',
                            lableText: 'New Password',
                            validator: AppValidator.validateRequired,
                          ),
                          SizedBox(height: 20.h),

                          state is ChangePasswordLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : CustomBTN(
                                  onPressed: cubit.onChangePasswordPressed,
                                  text: 'Save',
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
