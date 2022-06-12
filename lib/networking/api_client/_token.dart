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

    Result<AppToken> d = Result<AppToken>.fromJson(
      response.data,
      convert: (j) => AppToken.fromJson(j),
    );

    if (d.success && d.data != null) {
      AppToken? appToken = d.data;
      await sharedConfig.updateAccessToken(
        accessToken: appToken!.token.toString(),
      );
    }

    return d;
  }
}
