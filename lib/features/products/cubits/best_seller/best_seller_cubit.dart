import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/products/cubits/best_seller/best_seller_state.dart';
import 'package:yum_quick/features/products/data/models/best_seller/best_seller_model.dart';
import 'package:yum_quick/features/products/data/repos/products_repo.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  BestSellerCubit() : super(BestSellerInitialState());

  static BestSellerCubit get(BuildContext context) => BlocProvider.of(context);

  void getBestSeller() async {
    emit(BestSellerLoadinglState());
    ProductsRepo repo = ProductsRepo();
    var result = await repo.getBestSeller();
    result.fold(
      (error) => emit(BestSellerErrorState(error)),
      (List<BestSellerProductsModel> bestSeller) =>
          emit(BestSellerSuccessState(bestSeller: bestSeller)),
    );
  }
}
