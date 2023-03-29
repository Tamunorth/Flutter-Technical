// ignore_for_file: unused_catch_stack

import 'package:dio/dio.dart';

import 'network_imp_service.dart';

/// Helper class for converting [DioError] into readable formats
class ApiError {
  int? errorType = 0;
  ApiErrorModel? apiErrorModel;

  /// description of error generated this is similar to convention [Error.message]
  String? errorDescription;

  ApiError({this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  /// sets value of class properties from [error]
  void _handleError(Object error) {
    if (error is DioError) {
      DioError dioError = error; // as DioError;

      logger.e(error.response?.headers);
      logger.d(error.response?.data);
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription =
              "Connection timeout with server, please try again later";
          break;
        case DioErrorType.other:
          errorDescription =
              "Looks like you lost your connection. Please check it and try again";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription =
              "Receive timeout in connection with server, please try again later.";
          break;
        case DioErrorType.response:
          this.errorType = dioError.response?.statusCode;
          if (dioError.response?.statusCode == 401) {
            ///Log user out of the app
            // sl<SessionManager>().logOut();

            this.errorDescription =
                "Your session has timed out, please login again to proceed";
          } else if (dioError.response?.statusCode == 400 ||
              dioError.response?.statusCode == 422 ||
              dioError.response?.statusCode == 403) {
            this.apiErrorModel =
                ApiErrorModel.fromJson(dioError.response?.data);
            this.errorDescription = apiErrorModel!.msg ??
                extractDescriptionFromResponse(error.response);
          } else if (dioError.response?.statusCode == 500) {
            this.errorDescription =
                'Something went wrong while processing your request';
          } else if (dioError.response?.statusCode == 429) {
            this.errorDescription =
                'Something went wrong while processing your request,Please try again later';
          } else {
            this.errorDescription =
                "Oops! we couldn't make connections, please try again";
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription =
              "Looks like you lost your connection. Please check it and try again";
          break;
      }
    } else if (error is Response) {
      setKusnapErrorMessage(error);
    } else {
      logger.i(error.toString());
      errorDescription = "Oops an error occurred, we are fixing it";
    }
  }

  void setKusnapErrorMessage(Response error) {
    if (error.data['msg'] is String) {
      logger.e(error.data['msg']);
      errorDescription = error.data['msg'];
    } else {
      final erros = error.data['msg'] as Map<String, dynamic>;
      errorDescription = '';
      for (var element in erros.entries) {
        errorDescription = "$errorDescription${element.value},"
            .replaceAll('[', '')
            .replaceAll('.', '')
            .replaceAll(']', '');
      }
    }
  }

  String extractDescriptionFromResponse(Response<dynamic>? response) {
    String message = "";
    try {
      if (response?.data != null && response?.data["message"] != null) {
        message = response?.data["message"];
      } else {
        message = response?.statusMessage ?? '';
      }
    } catch (error, stackTrace) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => '$errorDescription';
}

class ApiErrorModel {
  int? code;
  String? msg;
  bool? success;

  ApiErrorModel({
    this.code,
    this.msg,
    this.success,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        code: json["errorCode"],
        msg: json["message"],
        success: json["success"],
      );
}
