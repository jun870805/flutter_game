import 'package:dio/dio.dart';
import 'package:flutter_game/networking/api_client/_record.dart';

import '../../includes.dart';
import './_token.dart';
import './_user.dart';
import '../tools/pretty_dio_logger.dart';

class ApiClient {
  static ApiClient shared = ApiClient();

  late Dio _http;
  late TokenService _tokenService;
  late RecordService _recordService;
  late UserService _userService;

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: sharedConfig.apiUrl,
      connectTimeout: 60000,
      receiveTimeout: 60000,
      headers: {
        "Accept": "application/json",
      },
      responseType: ResponseType.json,
    );
    _http = Dio(options);

    _http.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          String? accessToken = await sharedConfig.getCsrfToken();
          if ((accessToken ?? '').isNotEmpty) {
            options.headers['X-CSRFToken'] = accessToken;
          }
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          switch (e.type) {
            case DioErrorType.other:
              e.error = 'networkRequestError';
              break;
            case DioErrorType.connectTimeout:
              e.error = 'networkRequestTimeOut';
              break;
            case DioErrorType.response:
              if (e.response?.data['msg'] != null) {
                e.error = e.response?.data['msg']?.toString();
              } else {
                e.error = 'networkRequestFail';
              }

              break;
            default:
              break;
          }
          handler.next(e);
        },
      ),
    );

    _http.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 120,
    ));

    _tokenService = TokenService(_http);
    _recordService = RecordService(_http);
    _userService = UserService(_http);
  }

  Future<Response> download(String urlPath, String savePath) {
    return _http.download(urlPath, savePath);
  }

  Dio get http => _http;

  TokenService get token => _tokenService;

  RecordService get record => _recordService;

  UserService get user => _userService;

  String get networkErrorMessage {
    LocalizedString initialUrl = LocalizedString.fromJson({
      'localizedMap': {
        'en': 'Request failed,  please try again later.',
        'tw': '???????????????????????????????????????',
      }
    });

    return initialUrl.toString();
  }

  String get networkTimeOutMessage {
    LocalizedString initialUrl = LocalizedString.fromJson({
      'localizedMap': {
        'en': 'Request time out, please try again later.',
        'tw': '???????????????????????????????????????',
      }
    });

    return initialUrl.toString();
  }
}
