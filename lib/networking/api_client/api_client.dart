import 'package:dio/dio.dart';

import '../../includes.dart';
import './_token.dart';
import './_user.dart';
import '../tools/pretty_dio_logger.dart';

class ApiClient {
  static ApiClient shared = ApiClient();

  late Dio _http;
  late TokenService _tokenService;
  late UserService _userService;
  bool _isUseUserId = true;

  void noUseUserId() {
    _isUseUserId = false;
  }

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://side-game.herokuapp.com/',
      connectTimeout: 100000,
      receiveTimeout: 100000,
      headers: {
        "Accept": "application/json",
        // " Content-Type": "application/json",
      },
      responseType: ResponseType.json,
    );
    _http = Dio(options);

    _http.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print(options.path);
          // options.headers['X-CSRFToken'] =
          //     'IjkyMDNjMWUyMmRhMzMzODIyOTUwODVkZmQzNDFhZDZlYmEwZDg0YTci.YmRKPQ.jc-G06o03r2WEc1SpFhkM_F_93Y';
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print(response);
          // if (response.requestOptions.path != '/user/logout') {
          //   int code = response.data['code'];
          //   String msg = response.data['msg'];

          // }
          handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          switch (e.type) {
            case DioErrorType.other:
              //無context時改用current ex.S.of(context).* -> S.current.*
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
    _userService = UserService(_http);
  }

  Future<Response> download(String urlPath, String savePath) {
    return _http.download(urlPath, savePath);
  }

  Dio get http => _http;

  TokenService get token => _tokenService;

  UserService get user => _userService;

  String get networkErrorMessage {
    // LocalizedString initialUrl = LocalizedString.fromJson({
    //   'localizedMap': {
    //     'en': 'Request failed,  please try again later.',
    //     'tw': '網路請求失敗，請稍後重試。',
    //   }
    // });

    // return initialUrl.toString();
    return 'Request failed,  please try again later.';
  }

  String get networkTimeOutMessage {
    // LocalizedString initialUrl = LocalizedString.fromJson({
    //   'localizedMap': {
    //     'en': 'Request time out, please try again later.',
    //     'tw': '網路請求超時，請稍後重試。',
    //   }
    // });

    // return initialUrl.toString();
    return 'Request time out, please try again later.';
  }
}
