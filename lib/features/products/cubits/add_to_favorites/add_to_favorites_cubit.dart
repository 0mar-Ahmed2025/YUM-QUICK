import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/categories/data/model/categories_response_model.dart';
import 'package:yum_quick/features/products/cubits/add_to_favorites/add_to_favorites_state.dart';
import 'package:yum_quick/features/products/data/repos/products_repo.dart';

class AddToFavoritesCubit extends Cubit<AddToFavoritesState> {
  AddToFavoritesCubit(this.product) : super(AddToFavoritesInitial());

  final ProductModel product;

  static AddToFavoritesCubit get(BuildContext context) =>
      BlocProvider.of(context);

  void addToFavorites() async {
    emit(AddToFavoritesLoading());
    ProductsRepo repo = ProductsRepo();
    var result = await repo.addToFavorite(productId: product.id!);
    result.fold(
      (error) => emit(AddToFavoritesError(error)),
      (msg) => emit(AddToFavoritesSuccess()),
    );
  }
}
