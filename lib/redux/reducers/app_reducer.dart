import 'package:flutter/material.dart';

import '../../includes.dart';

import './global_reducer.dart';
import './user_reducer.dart';

AppState appReducer(AppState state, action) {
  if ((action is ResetAppStateAction)) {
    return state.resetState();
  }

  Langage langage = state.langage;
  String themeColor = state.themeColor;
  bool firstRun = state.firstRun;

  if (action is UpdateAppConfig) {
    if (action.langage != null && action.langage != langage) {
      langage = action.langage!;

      List<String> langageCodeSplited = langage.code.split('_');
      Locale defaultLocale = Locale(
        langageCodeSplited[0],
        langageCodeSplited[1],
      );

      sharedConfig.defaultLocale = defaultLocale;
    }
    themeColor = action.themeColor ?? '';
    firstRun = action.firstRun ?? true;

    action.completer.complete(true);
  }

  return AppState(
    langage: langage,
    themeColor: themeColor,
    firstRun: firstRun,
    globalState: globalReducer(state.globalState, action),
    userState: userReducer(state.userState, action),
  );
}
