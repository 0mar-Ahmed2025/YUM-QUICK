// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/auth/cubits/login/login_states.dart';
import 'package:yum_quick/features/auth/data/repo/auth_repo.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  AuthRepo repo = AuthRepo();
  var email = TextEditingController();
  var password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool passwordSecure = true;

  void changePasswordVisibility() {
    passwordSecure = !passwordSecure;
    emit(ChangePasswordVisibility());
  }

  login() async {
    if (formKey.currentState?.validate() == false) return;
    emit(LoginLoadingState());
    var result = await repo.login(email: email.text, password: password.text);
    result.fold(
      (errorMsg) => emit(LoginErrorState(error: errorMsg)),
      (model) => emit(LoginSuccessState(userModel: model)),
    );
  }
}
