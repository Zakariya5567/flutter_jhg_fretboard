import 'dart:developer';
import 'package:dio/dio.dart';

class DioConfig {
  var dio = Dio();
  DioConfig() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        options.headers['Content-Type'] = "application/json";
        options.headers["Accept"] = "application/json";
        options.connectTimeout = Duration(seconds: 120);
        options.sendTimeout = Duration(seconds: 120);
        options.receiveTimeout = Duration(seconds: 120);
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
     if (resp.statusCode == 200 || resp.statusCode == 201 )  {
       log("The link is $url & response is ${resp.data.toString()}");
       return resp.data;
     } else {
       log("Error: Received invalid status code: ${resp.statusCode}");
       return null;
     }
   } on DioException catch (e) {
     log("Dio error: ${e.type}, message: ${e.message}");
     if (e.response != null) {
       log("Response status: ${e.response?.statusCode}, data: ${e.response?.data}");
     }
     return null; // Return null or handle the error appropriately
   } catch (e) {
     log("Unexpected error: $e");
     return null; // Return null or handle the error appropriately
   }
 }

 post(url, data) async {
   log("POST to: $url with data: $data");
   try {
     var resp = await interceptor.dio.post(url, data: data);
     if (resp.statusCode == 200 || resp.statusCode == 201) {
       log("Response of POST to $url is: ${resp.data.toString()}");
       return resp.data;
     } else {
       log("Error: Received invalid status code: ${resp.statusCode}");
       return null; // Handle as needed
     }
   } on DioException catch (e) {
     log("Dio error: ${e.type}, message: ${e.message}");
     if (e.response != null) {
       log("Response status: ${e.response?.statusCode}, data: ${e.response?.data}");
     }
     return null; // Return null or handle the error appropriately
   } catch (e) {
     log("Unexpected error: $e");
     return null; // Return null or handle the error appropriately
   }
 }

}
