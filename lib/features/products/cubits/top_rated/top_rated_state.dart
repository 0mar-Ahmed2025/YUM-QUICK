import 'package:yum_quick/features/products/data/models/top_rated/top_rated_model.dart';

abstract class TopRatedState {}

class TopRatedInitialState extends TopRatedState {}

class TopRatedLoadinglState extends TopRatedState {}

class TopRatedErrorState extends TopRatedState {
  String error;
  TopRatedErrorState(this.error);
}

class TopRatedSuccessState extends TopRatedState {
  List<TopRatedProductsModel> topRated;
  TopRatedSuccessState({required this.topRated});
}
