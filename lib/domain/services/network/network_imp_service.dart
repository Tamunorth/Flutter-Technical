import 'package:dio/dio.dart';
import 'package:flutter_technical_assessment/domain/services/network/session_manager.dart';
import 'package:flutter_technical_assessment/domain/services/network/url_config.dart';
import 'package:logger/logger.dart';

import 'api_error.dart';

final logger = Logger();

class NetworkService {
  static const int CONNECT_TIME_OUT = 30000;
  static const int RECEIVE_TIME_OUT = 30000;
  Dio? dio;
  String? baseUrl, authToken;

  NetworkService({String? baseUrl, String? authToken}) {
    this.baseUrl = baseUrl;
    this.authToken = authToken;
    _initialiseDio();
  }

  /// Initialize essential class properties
  void _initialiseDio() {
    dio = Dio(BaseOptions(
      connectTimeout: CONNECT_TIME_OUT,
      receiveTimeout: RECEIVE_TIME_OUT,
      baseUrl: baseUrl ?? UrlConfig.coreBaseUrl,
    ));
    authToken ??= SessionManager.instance.authToken;
    dio!.interceptors.add(LogInterceptor(
      requestBody: true,
      logPrint: printDioLogs,
    ));
  }

  void printDioLogs(Object object) {
    printWrapped(object.toString());
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  /// Factory constructor used mainly for injecting an instance of [Dio] mock
  NetworkService.test(this.dio);

  Future<Response> call(
    String path,
    RequestMethod method, {
    Map<String, dynamic>? queryParams,
    data,
    FormData? formData,
    ResponseType responseType = ResponseType.json,
    classTag = '',
  }) async {
    Response response;
    var params = queryParams ?? {};
    if (params.keys.contains("searchTerm")) {
      params["searchTerm"] = Uri.encodeQueryComponent(params["searchTerm"]);
    }
    if (params.keys.contains("page")) {
      params["page"] = Uri.encodeQueryComponent(params["page"]);
    }
    try {
      switch (method) {
        case RequestMethod.post:
          response = await dio!.post(path,
              queryParameters: params, data: data, options: _getOptions());

          break;
        case RequestMethod.get:
          response = await dio!
              .get(path, queryParameters: params, options: _getOptions());
          break;
        case RequestMethod.put:
          response = await dio!.put(path,
              queryParameters: params, data: data, options: _getOptions());
          break;
        case RequestMethod.delete:
          response = await dio!.delete(path,
              queryParameters: params, data: data, options: _getOptions());
          break;
        case RequestMethod.upload:
          response = await dio!.post(path,
              data: formData,
              queryParameters: params,
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                "Content-Disposition": "form-data",
                "Content-Type": "multipart/form-data",
              }),
              onSendProgress: (sent, total) {});
          break;
        case RequestMethod.uploadPut:
          response = await dio!.put(path,
              data: formData,
              queryParameters: params,
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                "Content-Disposition": "form-data",
                "Content-Type": "multipart/form-data",
              }),
              onSendProgress: (sent, total) {});
          break;

        case RequestMethod.putSecond:
          response = await dio!.put(path,
              data: data,
              queryParameters: params,
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                "Content-Type": "application/json",
              }),
              onSendProgress: (sent, total) {});
          break;
      }

      if (response.data is List) {
        return response;
      } else {
        if (response.data['error'] == true) {
          logger.i(response.data.toString());
          var apiError = ApiError.fromDio(response);

          return Future.error(apiError);
        } else {
          return response;
        }
      }
    } catch (error, stackTrace) {
      if (error is DioError) {
        DioError dioError = error;

        if (error.response?.statusCode == 308) {
          logger.e(error.response?.headers);

          logger.wtf(error.response!.headers["location"]);

          response = await dio!.post(
              error.response!.headers["location"]!.join().toString(),
              queryParameters: params,
              data: data,
              options: _getOptions());

          return response;
        }
      }

      var apiError = ApiError.fromDio(error);
      if (apiError.errorType == 401) {}

      return Future.error(apiError, stackTrace);
    }
  }

  _getOptions() {
    return Options(contentType: Headers.formUrlEncodedContentType, headers: {
      'x-api-key': "36c8ca5c-6257-4c34-8944-5b88d15b79c6",
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
  }
}

enum RequestMethod { post, get, put, delete, upload, uploadPut, putSecond }
