import 'package:yum_quick/features/products/data/models/get_products/get_products_model.dart';

abstract class GetProductsState {}

class GetProductsInitialState extends GetProductsState {}

class GetProductsLoadinglState extends GetProductsState {}

class GetProductsErrorState extends GetProductsState {
  final String error;
  GetProductsErrorState(this.error);
}

class GetProductsSuccessState extends GetProductsState {
  List<ProductsModel> products;
  GetProductsSuccessState({required this.products});
}
