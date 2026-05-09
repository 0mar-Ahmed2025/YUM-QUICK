// ignore_for_file: strict_top_level_inference

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/auth/data/models/user_model.dart';
import 'package:yum_quick/features/users/cubits/get_user_data_cubit/get_user_data_states.dart';
import 'package:yum_quick/features/users/data/repos/user_repo.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit() : super(GetUserDataInitialState());
  static GetUserDataCubit get(context) => BlocProvider.of(context);

  void getUserDataPressed() async {
    emit(GetUserDataLoadingState());
    UserRepo repo = UserRepo();
    var result = await repo.getUserData();
    result.fold(
      (String error) => emit(GetUserDataErrorState(error)),
      (UserModel user) => emit(GetUserDataSuccessState(user)),
    );
  }
}
