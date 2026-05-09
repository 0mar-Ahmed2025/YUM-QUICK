// ignore_for_file: empty_catches, prefer_typing_uninitialized_variables
import 'package:dartz/dartz.dart';
import 'package:yum_quick/core/network/api_helper.dart';
import 'package:yum_quick/core/network/api_response.dart';
import 'package:yum_quick/core/network/end_points.dart';
import 'package:yum_quick/features/home/data/models/task_model.dart';

class HomeRepo {
  APIHelper apiHelper = APIHelper();

  Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      var response = await apiHelper.getRequest(
        isAuthorized: true,
        endPoint: EndPoints.getTasks,
      );
      var getTasksModel;

      if (response.status) {
        return right(getTasksModel.tasks ?? []);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
