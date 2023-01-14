import 'package:dio/dio.dart';
import '../config/api_config.dart';

class DIOService {
  static Dio createDio() {
    var dio = Dio(BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        receiveTimeout: 15000, // 15 seconds
        connectTimeout: 15000,
        sendTimeout: 15000,
        contentType: 'text/html'));
    return dio;
  }
}
