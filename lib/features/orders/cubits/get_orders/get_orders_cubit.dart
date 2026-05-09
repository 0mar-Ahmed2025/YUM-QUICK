// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/orders/cubits/get_orders/get_orders_state.dart';
import 'package:yum_quick/features/orders/data/models/orders_response_model.dart';
import 'package:yum_quick/features/orders/data/repo/orders_repo.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit(this.repo, {required this.orders}) : super(GetOrdersInitial());

  final OrdersRepo repo;
  static GetOrdersCubit get(BuildContext context) => BlocProvider.of(context);
  OrdersModel orders;

  int currentIndex = 0;
  onOrderTapped(int newIndex) {
    currentIndex = newIndex;
    emit(OrdersIndexChanged());
  }

  void getOrders() async {
    emit(GetOrdersLoading());
    var result = await repo.getOrders();
    result.fold((error) => emit(GetOrdersError(error: error)), (orders) {
      this.orders = orders;
      emit(GetOrdersSuccess());
    });
  }
}
