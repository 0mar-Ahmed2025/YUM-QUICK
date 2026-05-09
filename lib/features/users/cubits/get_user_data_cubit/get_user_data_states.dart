import 'package:yum_quick/features/auth/data/models/user_model.dart';

abstract class GetUserDataState {}

class GetUserDataInitialState extends GetUserDataState {}

class GetUserDataLoadingState extends GetUserDataState {}

class GetUserDataSuccessState extends GetUserDataState {
  final UserModel user;
  GetUserDataSuccessState(this.user);
}

class GetUserDataErrorState extends GetUserDataState {
  final String error;
  GetUserDataErrorState(this.error);
}
