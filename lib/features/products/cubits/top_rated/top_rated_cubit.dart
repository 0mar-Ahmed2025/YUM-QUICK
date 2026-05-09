import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/products/cubits/top_rated/top_rated_state.dart';
import 'package:yum_quick/features/products/data/models/top_rated/top_rated_model.dart';
import 'package:yum_quick/features/products/data/repos/products_repo.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit() : super(TopRatedInitialState());

  static TopRatedCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  void getTopRated() async {
    emit(TopRatedLoadinglState());
    ProductsRepo repo = ProductsRepo();
    var result = await repo.getTopRated();
    result.fold(
      (error) => emit(TopRatedErrorState(error)),
      (List<TopRatedProductsModel> topRated) =>
          emit(TopRatedSuccessState(topRated: topRated)),
    );
  }
}
