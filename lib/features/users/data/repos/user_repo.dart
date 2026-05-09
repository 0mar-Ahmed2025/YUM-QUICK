// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yum_quick/core/network/api_helper.dart';
import 'package:yum_quick/core/network/api_response.dart';
import 'package:yum_quick/core/network/end_points.dart';
import 'package:yum_quick/features/auth/data/models/user_model.dart';

class UserRepo {
  APIHelper apiHelper = APIHelper();

  Future<Either<String, String>> changeUserPasswor({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.changePassword,
        isAuthorized: true,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirm': newPasswordConfirm,
        },
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

  Future<Either<String, UserModel>> getUserData() async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getUserData,
        isAuthorized: true,
      );
      if (response.status) {
        UserModel user = UserModel.fromJson(
          (response.data as Map<String, dynamic>)['user']
              as Map<String, dynamic>,
        );
        return right(user);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, String>> updateUserProfile({
    required String userName,
    required String phone,
    XFile? image,
  }) async {
    try {
      // 1. نجهز الداتا النصية الأول
      Map<String, dynamic> requestData = {'name': userName, 'phone': phone};

      // 2. لو اليوزر اختار صورة، نحولها لـ MultipartFile عشان تترفع صح
      if (image != null) {
        requestData['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }

      // 3. نبعت الريكويست
      var response = await apiHelper.putRequest(
        endPoint: EndPoints.updateProfile,
        isProtected: true,
        data: requestData,
      );

      if (response.status) {
        print(response.data);
        return right(response.message);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
