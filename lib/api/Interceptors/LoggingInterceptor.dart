import 'package:bytebanksqlite/api/HttpException.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  static final Map<int, String> _statusCodeResponse = {
    400: 'There was an error.',
    401: 'Invalid password.',
  };

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('Url: ${data.baseUrl}');
    print('Body: ${data.body}');
    data.headers.addAll({'Content-type': 'application/json'});
    print('Headers: ${data.headers}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('Status code: ${data.statusCode}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    if(data.statusCode > 199 && data.statusCode < 300) {
      return data;
    }
    throw HttpException(_statusCodeResponse[data.statusCode]);
  }
}