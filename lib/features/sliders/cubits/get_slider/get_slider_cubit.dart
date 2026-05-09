import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/sliders/cubits/get_slider/get_slider_state.dart';
import 'package:yum_quick/features/sliders/data/models/slider_model.dart';
import 'package:yum_quick/features/sliders/data/repos/slider_repo.dart';

class GetSliderCubit extends Cubit<GetSliderState> {
  GetSliderCubit() : super(GetSliderIntialState());

  static GetSliderCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  void onIndexChanged(int newIndex) {
    currentIndex = newIndex;
    emit(SliderChangedState());
  }

  void getSliders() async {
    emit(GetSliderLoadingState());
    SliderRepo repo = SliderRepo();
    var result = await repo.getSliders();
    result.fold(
      (error) => emit(GetSliderErrorState(error)),
      (List<SliderModel> sliders) =>
          emit(GetSliderSuccessState(sliders: sliders)),
    );
  }
}
