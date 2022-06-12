import 'dart:async';
import 'package:dio/dio.dart';

import '../../includes.dart';

class UserService {
  final Dio _http;

  UserService(this._http);

  // 註冊
  Future<Result> signUp({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> _parm = {};

    _parm['username'] = username;
    _parm['password'] = password;

    final response = await _http.post(
      '/signup',
      data: {
        'username': username,
        'password': password,
      },
    );

    return Result.fromJson(response.data);
  }

  // 登入
  Future<Result<User>> login({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> _parm = {};

    _parm['username'] = username;
    _parm['password'] = password;

    final response = await _http.post(
      '/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    Result<User> d = Result<User>.fromJson(
      response.data,
      convert: (j) => User.fromJson(j),
    );

    if (d.success && d.data != null) {
      User? user = d.data;
      await sharedConfig.updateUserId(
        userId: user!.id.toString(),
      );
    }

    return d;
  }

  // 登出
  Future<Result<User>> logOut() async {
    final response = await _http.get('/logout');

    return Result.fromJson(response.data);
  }
}
