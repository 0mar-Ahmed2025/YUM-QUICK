// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_quick/features/auth/data/models/user_model.dart';
import 'package:yum_quick/features/users/cubits/updat_user_profile/update_user_profile_state.dart';
import 'package:yum_quick/features/users/data/repos/user_repo.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.userModel) : super(UpdateProfileInitialState()) {
    userName.text = userModel.username ?? '';
    phone.text = userModel.phone ?? '';
  }
  static UpdateProfileCubit get(context) => BlocProvider.of(context);
  final UserModel userModel;

  XFile? image;
  void pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(UpdateProfileImageChangedState());
  }

  var userName = TextEditingController();
  var phone = TextEditingController();

  var formKey = GlobalKey<FormState>();

  void onUpdatePorfilePressed() async {
    if (formKey.currentState?.validate() == true) {
      emit(UpdateProfileLoadingState());
      UserRepo repo = UserRepo();
      var result = await repo.updateUserProfile(
        phone: phone.text,
        userName: userName.text,
        image: image,
      );
      result.fold(
        (String error) => emit(UpdateProfileErrorState(error)),
        (u) => emit(UpdateProfileSuccessState()),
      );
    }
  }
}
