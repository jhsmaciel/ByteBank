import 'package:bytebanksqlite/api/Interceptors/LoggingInterceptor.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

final httpClientWithInterceptor = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

const basePath = 'http://192.168.3.108:8080/transactions';
