import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_quick/features/sliders/cubits/add_slider/add_slider_state.dart';
import 'package:yum_quick/features/sliders/data/repos/slider_repo.dart';

class AddSliderCubit extends Cubit<AddSliderState> {
  AddSliderCubit() : super(AddSliderIntialState());

  static AddSliderCubit get(BuildContext context) => BlocProvider.of(context);

  var title = TextEditingController();
  var description = TextEditingController();
  var formKey = GlobalKey<FormState>();
  XFile? image;
  void pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(AddSliderImageChangeState());
  }

  void onAddTaskPressed() async {
    if (formKey.currentState?.validate() == true) {
      emit(AddSliderLoadingState());
      SliderRepo repo = SliderRepo();
      var result = await repo.addSlider(
        title: title.text,
        description: description.text,
        image: image,
      );
      result.fold(
        (String error) => emit(AddSliderErrorState(error)),
        (u) => emit(AddSliderSuccessState()),
      );
    }
  }
}
