import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/products/cubits/get_products/get_products_state.dart';
import 'package:yum_quick/features/products/data/models/get_products/get_products_model.dart';
import 'package:yum_quick/features/products/data/repos/products_repo.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitialState());

  static GetProductsCubit get(BuildContext context) => BlocProvider.of(context);

  void getProducts() async {
    emit(GetProductsLoadinglState());
    ProductsRepo repo = ProductsRepo();
    var result = await repo.getProducts();
    result.fold(
      (error) => emit(GetProductsErrorState(error)),
      (List<ProductsModel> products) =>
          emit(GetProductsSuccessState(products: products)),
    );
  }
}
