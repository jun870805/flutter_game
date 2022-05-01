import 'dart:convert';

class ResultWithList<T> {
  bool? success;
  int? code;
  String? msg;
  List<T>? data;

  ResultWithList({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  factory ResultWithList.empty() {
    return ResultWithList<T>(
      data: [],
    );
  }

  factory ResultWithList.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic json)? convert,
  }) {
    List<T> data = [];
    if (json['data'] != null && convert != null) {
      Iterable l = json['data'] as List;
      data = l.map((item) => convert(item)).toList();
    }

    return ResultWithList(
      success: json['success'] ?? json['code'] == 1,
      code: json['code'],
      msg: json['msg'],
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'msg': msg,
      'data': data != null ? json.encode(data) : null,
    };
  }
}
