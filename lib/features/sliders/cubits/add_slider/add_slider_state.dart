abstract class AddSliderState {}

class AddSliderIntialState extends AddSliderState {}

class AddSliderErrorState extends AddSliderState {
  String error;
  AddSliderErrorState(this.error);
}

class AddSliderLoadingState extends AddSliderState {}

class AddSliderSuccessState extends AddSliderState {}

class AddSliderImageChangeState extends AddSliderState {}
