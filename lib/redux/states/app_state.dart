import 'dart:convert';

import '../../includes.dart';

export './global_state.dart';
export './user_state.dart';

class AppState {
  late final Langage langage;
  late final String themeColor;
  late final bool firstRun;
  late final GlobalState globalState;
  late final UserState userState;

  AppState({
    required this.langage,
    required this.themeColor,
    required this.firstRun,
    required this.globalState,
    required this.userState,
  });

  static AppState fromJson(dynamic jsonText) {
    jsonText ??= {};

    return AppState(
      langage: Langage.fromJson(jsonText['langage']) ?? Langage.defaultLangage,
      themeColor: jsonText['themeColor'] ?? 'bright',
      globalState:
          GlobalState.fromJson(jsonText['globalState']) ?? GlobalState(),
      userState: UserState.fromJson(jsonText['userState']) ?? UserState(),
      firstRun: jsonText['firstRun'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'langage': langage.toJson(),
      'themeColor': themeColor,
      'firstRun': firstRun,
      'globalState': globalState.toJson(),
      'userState': userState.toJson(),
    };
  }

  AppState resetState() {
    langage = Langage.defaultLangage;
    themeColor = 'bright';
    firstRun = true;
    globalState = GlobalState();
    userState = UserState();

    return this;
  }
}
