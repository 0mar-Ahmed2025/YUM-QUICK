// ignore_for_file: empty_catches

import 'package:dartz/dartz.dart';
import 'package:yum_quick/core/network/api_helper.dart';
import 'package:yum_quick/core/network/api_response.dart';
import 'package:yum_quick/core/network/end_points.dart';
import 'package:yum_quick/features/products/data/models/best_seller/best_seller_model.dart';
import 'package:yum_quick/features/products/data/models/best_seller/best_seller_response_model.dart';
import 'package:yum_quick/features/products/data/models/get_products/get_products_model.dart';
import 'package:yum_quick/features/products/data/models/get_products/get_products_response_model.dart';
import 'package:yum_quick/features/products/data/models/top_rated/top_rated_model.dart';
import 'package:yum_quick/features/products/data/models/top_rated/top_rated_response_model.dart';

class ProductsRepo {
  APIHelper apiHelper = APIHelper();

  Future<Either<String, List<TopRatedProductsModel>>> getTopRated() async {
    try {
      var response = await apiHelper.getRequest(
        isAuthorized: true,
        endPoint: EndPoints.topRated,
      );
      var getTopProductsModel = TopRatedResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      if (response.status) {
        return right(getTopProductsModel.topRatedProducts ?? []);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, List<BestSellerProductsModel>>> getBestSeller() async {
    try {
      var response = await apiHelper.getRequest(
        isAuthorized: true,
        endPoint: EndPoints.bestSeller,
      );
      var getBestSellerModel = BestSellerResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      if (response.status) {
        return right(getBestSellerModel.bestSellerProducts ?? []);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, List<ProductsModel>>> getProducts() async {
    try {
      var response = await apiHelper.getRequest(
        isAuthorized: true,
        endPoint: EndPoints.getProducts,
      );
      var getProductsModel = GetProductResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      if (response.status) {
        return right(getProductsModel.products ?? []);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, String>> addToFavorite({required int productId}) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.addToFavorites,
        isAuthorized: true,
        data: {'product_id': productId},
      );
      if (response.status) {
        // serialization
        return right(response.message);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, List<dynamic>>> searchProducts(String query) async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: 'products/search',
        isAuthorized: true,
        queryParams: {'q': query},
      );

      if (response.status) {
        return right(response.data);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
