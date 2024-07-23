import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _singleton = HttpService._internal();

  final _dio = Dio();

  final BASE_URL = 'https://dummyjson.com/';

  factory HttpService() {
    return _singleton;
  }

  HttpService._internal() {
    setupBaseRequest();
  }

  Future<void> setupBaseRequest({String? bearerToken = ""}) async {
    final headers = {'Content-Type': 'application/json'};

    if (bearerToken != null) {
      headers['Authorization'] = "Bearer $bearerToken";
    }

    final options = BaseOptions(
      baseUrl: BASE_URL,
      headers: headers,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;
      },
    );
    _dio.options = options;
  }

  Future<Response?> get(path) async {
    try {
      final response = _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = _dio.post(path, data: data);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
