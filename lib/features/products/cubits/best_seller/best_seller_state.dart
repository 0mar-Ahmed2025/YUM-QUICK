import 'package:yum_quick/features/products/data/models/best_seller/best_seller_model.dart';

abstract class BestSellerState {}

class BestSellerInitialState extends BestSellerState {}

class BestSellerLoadinglState extends BestSellerState {}

class BestSellerErrorState extends BestSellerState {
  final String error;
  BestSellerErrorState(this.error);
}

class BestSellerSuccessState extends BestSellerState {
  List<BestSellerProductsModel> bestSeller;
  BestSellerSuccessState({required this.bestSeller});
}
