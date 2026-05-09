// ignore_for_file: strict_top_level_inference, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/users/cubits/change_pasword/change_password_state.dart';
import 'package:yum_quick/features/users/data/repos/user_repo.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var currentPassword = TextEditingController();
  var newPassword = TextEditingController();
  var newPasswordConfirm = TextEditingController();

  void onChangePasswordPressed() async {
    if (formKey.currentState?.validate() == false) return;
    emit(ChangePasswordLoadingState());
    UserRepo repo = UserRepo();

    var result = await repo.changeUserPasswor(
      currentPassword: currentPassword.text,
      newPassword: newPassword.text,
      newPasswordConfirm: newPasswordConfirm.text,
    );
    result.fold(
      (error) => emit(ChangePasswordErrorState(error)),
      (msg) => emit(ChangePasswordSuccessState()),
    );
  }
}
