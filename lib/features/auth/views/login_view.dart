import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/core/helper/app_pop_up.dart';
import 'package:yum_quick/core/helper/app_validator.dart';
import 'package:yum_quick/core/shared/custom_btn.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/shared/custom_text_field.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/features/auth/cubits/login/login_cubit.dart';
import 'package:yum_quick/features/auth/cubits/login/login_states.dart';
import 'package:yum_quick/features/get_start/views/welcome_view.dart';
import 'package:yum_quick/features/home/views/main_layout.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is LoginSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message:
                    'Login successfully\n Welcome ${state.userModel.username}',
                state: PopUpState.success,
              );
              MyNavigator.goto(
                context,
                MainLayout(),
                type: NavigatorType.pushAndRemoveUntil,
              );
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40.0,
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
                          'Hello!',
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
                              const Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  // color: textColor,
                                ),
                              ),
                              const SizedBox(height: 30),

                              CustomTextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: cubit.email,
                                validator: AppValidator.validateRequired,
                                textFieldName: 'Email',
                                hintText: 'Enter Email Here',
                              ),
                              const SizedBox(height: 10),

                              CustomTextField(
                                keyboardType: TextInputType.number,
                                obscureText: cubit.passwordSecure,
                                controller: cubit.password,
                                validator: AppValidator.validateRequired,
                                textFieldName: 'Password',
                                hintText: 'Enter Password Here',
                                suffixIcon: IconButton(
                                  onPressed: cubit.changePasswordVisibility,
                                  icon: CustomSvgWrapper(
                                    path: 'assets/icons/show_off_icon.svg',
                                  ),
                                ),
                              ),

                              const SizedBox(height: 60),
                              state is LoginLoadingState
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.orange,
                                      ),
                                    )
                                  : Center(
                                      child: CustomBTN(
                                        text: 'Log In',
                                        onPressed: () => cubit.login(),
                                        backColor: AppColors.orange,
                                        frontColor: AppColors.white,
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
