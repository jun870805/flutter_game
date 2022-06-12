import 'dart:async';
import 'package:dio/dio.dart';

import '../../includes.dart';

class RecordService {
  final Dio _http;

  RecordService(this._http);

  // 新增紀錄
  Future<Result> insertRecord({
    required int point,
    required int rank,
  }) async {
    Map<String, dynamic> _parm = {};

    _parm['point'] = point;
    _parm['rank'] = rank;

    final response = await _http.post(
      '/Insert_Record',
      data: _parm,
    );

    return Result.fromJson(response.data);
  }

  // 新增紀錄
  Future<Result<Record>> queryRecord({
    int uid = 0,
  }) async {
    Map<String, dynamic> _parm = {};

    _parm['uid'] = uid;

    final response = await _http.post(
      '/QueryRecord',
      data: _parm,
    );

    return Result<Record>.fromJson(
      response.data,
      convert: (j) => Record.fromJson(j),
    );
  }
}
