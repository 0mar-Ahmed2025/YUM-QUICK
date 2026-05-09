abstract class GetOrdersState {}

class GetOrdersInitial extends GetOrdersState {}

class GetOrdersLoading extends GetOrdersState {}

class GetOrdersError extends GetOrdersState {
  String error;
  GetOrdersError({required this.error});
}

class GetOrdersSuccess extends GetOrdersState {}

class OrdersIndexChanged extends GetOrdersState {}
