import 'dart:convert';

class Result<T> {
  bool success;
  int? code;
  String? msg;
  T? data;

  Result({
    required this.success,
    this.code,
    this.msg,
    this.data,
  });

  factory Result.empty() {
    return Result<T>(
      success: false,
      data: null,
    );
  }

  factory Result.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic> json)? convert,
  }) {
    T? data;
    if (json['data'] != null) {
      if (convert != null) {
        data = convert(json['data']);
      } else {
        try {
          data = json['data'];
        } catch (e) {}
      }
    }

    return Result(
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
