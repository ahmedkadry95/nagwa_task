import 'package:dio/dio.dart';

class NetworkHelper {
  late final Dio _dio;

  NetworkHelper(this._dio);

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: query,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> getUri(String url) async {
    final response = await _dio.getUri(Uri.parse(url));
    return response.data;
  }

  Future<dynamic> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.post(
      path,
      data: body,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> put(
    String path, {
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.put(
      path,
      data: body,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
