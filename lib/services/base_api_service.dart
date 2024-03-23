import 'dart:developer';
import 'package:dio/dio.dart';

class DioConfig {
  var dio = Dio();
  DioConfig() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.headers['Content-Type'] = "application/json";
        options.headers["Accept"] = "application/json";
        try {
          // var token = await Storage.getToken();
          // log("my token is $token");
          //options.headers["Authorization"] = "Bearer $token";
        } catch (e) {
          log(e.toString());
        }
        return handler.next(options);
      },
      onResponse: (e, handler) async {
        return handler.next(e);
      },
      onError: (e, handler) async {
        return handler.next(e);
      },
    ));
  }
}

class BaseApiService {
  var interceptor = DioConfig();
  get(url) async {
    log("$url");
    log("The link & body is $url");
    try {
      var resp = await interceptor.dio.get(url);
      if (resp.statusCode == 200) {
        log("The link is $url & response is ${resp.data.toString()}");
        return resp.data;
      } else {
        return null;
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return e;
    }
  }

  post(url, data) async {
    log("$url $data");
    try {
      var resp = await interceptor.dio.post(url, data: data);
      log("Response of $url is : ${resp.data.toString()}");

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      log(e.message.toString());
      return e;
    }
  }
}
