import 'dart:async';
import 'package:dio/dio.dart';

import '../../includes.dart';

class UserService {
  final Dio _http;

  UserService(this._http);

  Future<Result<User>> login({
    required String username,
    required String password,
  }) async {
    final response = await _http.post(
      '/login',
      data: {
        'username': username,
        'password': password,
      },
    );
    var d = Result.fromJson(
      response.data,
      convert: (d) => User.fromJson(d),
    );
    if (d.success && d.data != null) {
      User? user = d.data;
      // await sharedConfig.update(
      //   userId: user!.id.toString(),
      // );
    }
    return d;
  }

  Future<Result<User>> userCenter() async {
    final response = await _http.get(
      '/user',
    );

    var d = Result<User>.fromJson(
      response.data,
      convert: (j) => User.fromJson(j),
    );
    return d;
  }

  Future<Result> logout() async {
    final response = await _http.post('/user/logout');

    // await sharedConfig.update(
    //   userId: null,
    // );

    Result r = Result.fromJson(response.data);

    return r;
  }
}
