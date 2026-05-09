import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/products/cubits/search/search_state.dart';
import 'package:yum_quick/features/products/data/repos/products_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);
  final ProductsRepo repo = ProductsRepo();

  Timer? _debounce;

  void search(String query) {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchLoading());

      var result = await repo.searchProducts(query);

      result.fold(
        (error) => emit(SearchError(error)),
        (products) => emit(SearchSuccess(products)),
      );
    });
  }
}
