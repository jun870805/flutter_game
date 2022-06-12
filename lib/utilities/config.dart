import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show DeviceOrientation, SystemChrome, rootBundle;
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import '../includes.dart';

Future<Config> initConfig(
  String type,
) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  String jsonString = await rootBundle.loadString('assets/configs/$type.json');
  Map map = jsonDecode(jsonString);

  Config config = Config();

  config.env = map["env"];
  config.apiUrl = map["apiUrl"];

  Config.shared = config;

  StorageEngine storageEngine = FlutterStorage();

  // Create Persistor
  final persistor = Persistor<AppState>(
    storage: storageEngine,
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  AppState? initialState;
  try {
    initialState = await persistor.load();
  } catch (error) {
    // ignore this error.
  } finally {
    initialState ??= AppState.fromJson(null);
  }

  if (Config().apiHeaderXClientType != 'PC') {
    var temporaryDirectory = await getTemporaryDirectory();
    print(temporaryDirectory);
  }

  config.store = Store<AppState>(appReducer,
      initialState: initialState,
      middleware: []
        // ..addAll(appMiddlewares)
        ..add(persistor.createMiddleware())
      // ..addAll(reduxMiddlewares ?? [])
      );

  print(jsonString);

  return config;
}

class Config {
  static late Config shared;

  late String env;
  late String apiUrl;
  late String wsUrl;

  Locale? defaultLocale;

  String get apiHeaderLang {
    String lang = 'en';
    if (defaultLocale != null) {
      String languageCode = defaultLocale.toString();
      switch (languageCode) {
        case 'zh_CN':
          lang = 'cn';
          break;
        case 'zh_TW':
          lang = 'tw';
          break;
        case 'id_ID':
          lang = 'id';
          break;
        case 'vi_VN':
          lang = 'vn';
          break;
        default:
          lang = 'en';
          break;
      }
    }
    return lang;
  }

  String get apiHeaderXClientType {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        if (Platform.isAndroid) {
          return 'android';
        } else if (Platform.isIOS) {
          return 'ios';
        }
      } else {
        return 'PC';
      }
    } catch (e) {
      return 'PC';
    }

    return 'PC';
  }

  Future updateUserId({
    String? userId,
  }) async {
    await _setString('user_id', userId);
  }

  Future updateAccessToken({
    String? accessToken,
  }) async {
    await _setString('user_id', accessToken);
  }

  Future<String?> getUserId() async {
    return await _getString('user_id');
  }

  Future<bool> _setString(String key, String? value) async {
    try {
      if (value == null) {
        (await SharedPreferences.getInstance()).remove(key);
      } else {
        (await SharedPreferences.getInstance()).setString(key, value);
      }
    } catch (e) {
      rethrow;
    }
    return true;
  }

  Future<String?> _getString(String key, {String? defaultValue}) async {
    String? value;
    try {
      value = (await SharedPreferences.getInstance()).getString(key);
    } catch (e) {
      rethrow;
    }
    return value ?? defaultValue;
  }

  late Store<AppState> store;

  Future<String?> getCsrfToken() async {
    return await _getString('access_token');
  }
}
