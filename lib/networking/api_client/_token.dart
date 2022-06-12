import 'dart:async';
import 'package:dio/dio.dart';

import '../../includes.dart';

class TokenService {
  final Dio _http;

  TokenService(this._http);

  // 取得token
  Future<Result<AppToken>> getCsrf() async {
    final response = await _http.get(
      '/GetCsrf',
    );

    print(response);

    await sharedConfig.updateAccessToken(
      accessToken: response.data['X-CSRFToken'],
    );

    return Result<AppToken>.fromJson(
      response.data,
      convert: (j) => AppToken.fromJson(j),
    );
  }
}
