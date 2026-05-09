// ignore_for_file: strict_top_level_inference

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/categories/cubit/categories_state.dart';
import 'package:yum_quick/features/categories/data/model/categories_response_model.dart';
import 'package:yum_quick/features/categories/data/repo/categories_repo.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.repo) : super(CategoriesInitial());
  final CategoriesRepo repo;
  static CategoriesCubit get(context) => BlocProvider.of(context);
  List<CategoryModel>? categories;

  int currentIndex = 0;
  onCategoryTapped(int newIndex) {
    currentIndex = newIndex;
    emit(CategoriesIndexChanged());
  }

  void getCategories() async {
    emit(CategoriesLoading());
    var result = await repo.getCategories();
    result.fold((error) => emit(CategoriesError(error: error)), (categories) {
      this.categories = categories;
      emit(CategoriesSuccess());
    });
  }
}
