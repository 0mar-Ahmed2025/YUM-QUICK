import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/core/helper/app_pop_up.dart';
import 'package:yum_quick/core/helper/app_validator.dart';
import 'package:yum_quick/core/shared/custom_btn.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/shared/custom_text_field.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/features/auth/cubits/register/register_cubit.dart';
import 'package:yum_quick/features/auth/cubits/register/register_states.dart';
import 'package:yum_quick/features/auth/views/login_view.dart';
import 'package:yum_quick/features/get_start/views/welcome_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is RegisterSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message: state.message,
                state: PopUpState.success,
              );
              MyNavigator.goto(
                context,
                LoginView(),
                type: NavigatorType.pushAndRemoveUntil,
              );
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubit.get(context);
            return SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            MyNavigator.goto(
                              context,
                              WelcomeView(),
                              type: NavigatorType.pushAndRemoveUntil,
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.orange,
                            size: 20,
                          ),
                        ),
                        const Text(
                          'New Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 30.0,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),

                              CustomTextField(
                                keyboardType: TextInputType.text,
                                controller: cubit.username,
                                validator: AppValidator.validateRequired,
                                textFieldName: 'Ful Name',
                                hintText: 'Enter Your Full Name',
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: cubit.email,
                                validator: AppValidator.validateRequired,
                                textFieldName: 'Email',
                                hintText: 'example@example.com',
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                keyboardType: TextInputType.phone,
                                controller: cubit.phone,
                                validator: AppValidator.validateRequired,
                                textFieldName: 'Mobile Number',
                                hintText: '+ 123 456 789',
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                keyboardType: TextInputType.number,
                                controller: cubit.password,
                                validator: AppValidator.validateRequired,
                                textFieldName: 'Password',
                                hintText: 'Enter Your Password',
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: CustomSvgWrapper(
                                    path: 'assets/icons/show_off_icon.svg',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              CustomTextField(
                                keyboardType: TextInputType.number,
                                controller: cubit.confirmPassword,
                                validator: AppValidator.validateRequired,
                                textFieldName: 'Confirm Password',
                                hintText: 'Confirm Your Password',
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: CustomSvgWrapper(
                                    path: 'assets/icons/show_off_icon.svg',
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                              state is RegisterLoadingState
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.orange,
                                      ),
                                    )
                                  : Center(
                                      child: CustomBTN(
                                        text: 'Register',
                                        onPressed: () => cubit.register(),
                                        backColor: AppColors.orange,
                                        frontColor: AppColors.white,
                                      ),
                                    ),
                              const SizedBox(height: 15),
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    text:
                                        'By continuing, you agree to\n', // النص العادي
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Terms of Use ',
                                        style: const TextStyle(
                                          color: AppColors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'and ',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text:
                                            'Privacy Policy.', // النص الملون الثاني
                                        style: const TextStyle(
                                          color: AppColors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
