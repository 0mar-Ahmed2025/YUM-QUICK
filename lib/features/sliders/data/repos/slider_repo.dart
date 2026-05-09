import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_quick/core/network/api_helper.dart';
import 'package:yum_quick/core/network/api_response.dart';
import 'package:yum_quick/core/network/end_points.dart';
import 'package:yum_quick/features/sliders/data/models/slider_model.dart';
import 'package:yum_quick/features/sliders/data/models/slider_response_model.dart';

class SliderRepo {
  APIHelper apiHelper = APIHelper();

  Future<Either<String, Unit>> addSlider({
    required String title,
    required String description,
    XFile? image,
  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.addSlider,
        isAuthorized: true,
        data: {
          'title': title,
          'description': description,
          if (image != null) 'image': await MultipartFile.fromFile(image.path),
        },
      );
      if (response.status) {
        return right(unit);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, String>> updateTask({
    required String title,
    required String description,
    required int sliderId,
    XFile? image,
  }) async {
    try {
      var response = await apiHelper.putRequest(
        endPoint: '${EndPoints.updateOrDeleteSlider}/$sliderId',
        isProtected: true,
        data: {
          'title': title,
          'description': description,
          if (image != null) 'image': await MultipartFile.fromFile(image.path),
        },
      );
      if (response.status) {
        return right(response.message);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, String>> deleteTask({required int taskId}) async {
    try {
      var response = await apiHelper.deleteRequest(
        endPoint: '${EndPoints.updateOrDeleteSlider}/$taskId',
        isAuthorized: true,
      );
      if (response.status) {
        return right(response.message);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, List<SliderModel>>> getSliders() async {
    try {
      var response = await apiHelper.getRequest(
        isAuthorized: true,
        endPoint: EndPoints.getSliders,
      );
      var getSlidersModel = GetSlidersReponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      if (response.status) {
        return right(getSlidersModel.sliders ?? []);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
