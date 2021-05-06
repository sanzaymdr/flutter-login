import 'package:dio/dio.dart';

class ApiRequests {
  final Dio _dio = new Dio();

  getRequest(String url, String jwtAuth) async {
    try {
      var response = await _dio.get(
        url,
        queryParameters: {'jwt': jwtAuth},
      );
      return response;
    } on DioError catch (e) {
      return {
        "status": 0,
        "error": e?.response?.statusMessage,
      };
    } catch (e) {
      print(e);
      return null;
    }
  }

  postRequest(String url, Map data) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response;
    } on DioError catch (e) {
      return {
        "status": 0,
        "error": e?.response?.statusMessage,
      };
    } catch (e) {
      print(e);
      return null;
    }
  }

  putRequest(String url, var data) async {
    try {
      Response response = await _dio.put(url, data: data);
      return response;
    } on DioError catch (e) {
      return {
        "status": 0,
        "error": e?.response?.statusMessage,
      };
    } catch (e) {
      print(e);
      return null;
    }
  }
}
