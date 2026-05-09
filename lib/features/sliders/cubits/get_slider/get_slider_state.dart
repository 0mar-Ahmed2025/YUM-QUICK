import 'package:yum_quick/features/sliders/data/models/slider_model.dart';

abstract class GetSliderState {}

class GetSliderIntialState extends GetSliderState {}

class GetSliderErrorState extends GetSliderState {
  String error;
  GetSliderErrorState(this.error);
}

class GetSliderLoadingState extends GetSliderState {}

class GetSliderSuccessState extends GetSliderState {
  List<SliderModel> sliders;
  GetSliderSuccessState({required this.sliders});
}

class GetSliderImageChangeState extends GetSliderState {}

class SliderChangedState extends GetSliderState {}
