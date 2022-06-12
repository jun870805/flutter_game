import 'package:flutter/material.dart';

class Langage {
  String code;
  String name;

  Langage({
    this.code = 'en_US',
    this.name = 'English',
  });

  static Langage? fromJson(Map<String, dynamic>? json) {
    if (json == null) return Langage();

    return Langage(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }

  Locale toLocale() {
    List<String>? langageCodeSplited = code.split('_');
    Locale defaultLocale = Locale(
      langageCodeSplited[0],
      langageCodeSplited[1],
    );
    return defaultLocale;
  }

  static Langage defaultLangage = supportedLangages.firstWhere(
    (v) => v.code == 'en_US',
  );

  static setDefalutLanguage(String locale) {
    String code = 'en_US';
    locale = locale.toLowerCase();

    if (locale.contains('en')) {
      code = 'en_US';
    } else if (locale.contains('tw')) {
      code = 'zh_TW';
    }

    defaultLangage = supportedLangages.firstWhere(
      (v) => v.code == code,
    );
  }

  static final List<Langage> supportedLangages = [
    Langage(
      code: 'en_US',
      name: 'English',
    ),
    Langage(
      code: 'zh_TW',
      name: '繁體中文',
    ),
  ];
}
