import 'package:dartz/dartz.dart';
import 'package:yum_quick/core/network/api_helper.dart';
import 'package:yum_quick/core/network/api_response.dart';
import 'package:yum_quick/core/network/end_points.dart';
import 'package:yum_quick/features/orders/data/models/orders_response_model.dart';

class OrdersRepo {
  APIHelper apiHelper = APIHelper();
  Future<Either<String, OrdersModel>> getOrders() async {
    try {
      var response = await apiHelper.getRequest(endPoint: EndPoints.orders);

      if (response.status) {
        var ordersResponse = OrdersResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        return right(ordersResponse.orders!);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
