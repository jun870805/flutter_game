import 'dart:convert';

import '../includes.dart';

class LocalizedString {
  Map<String, dynamic>? localizedMap;

  LocalizedString({
    String? en,
    String? tw,
    this.localizedMap,
  }) {
    localizedMap ??= {
      'en': en,
      'tw': tw,
    };
  }

  factory LocalizedString.fromDynamic(dynamic j) {
    if (j is String) return LocalizedString.fromJsonString(j);

    return LocalizedString.fromJson(j);
  }

  factory LocalizedString.fromJson(Map<String, dynamic>? json) {
    if (json == null) return LocalizedString();

    return LocalizedString(
      localizedMap: json['localizedMap'],
    );
  }

  factory LocalizedString.fromJsonString(String? jsonString) {
    if (jsonString == null) return LocalizedString();

    Map<String, dynamic> localizedMap = json.decode(jsonString);

    return LocalizedString(
      localizedMap: localizedMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localizedMap': localizedMap,
    };
  }

  @override
  String toString() {
    String key = sharedConfig.apiHeaderLang;
    return localizedMap![key] ?? localizedMap!['en'];
  }

  List<String> toList() {
    String key = sharedConfig.apiHeaderLang;
    return localizedMap![key] ?? localizedMap!['en'];
  }
}
