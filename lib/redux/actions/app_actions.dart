export './global_actions.dart';
export './user_actions.dart';

import 'dart:async';

import '../../includes.dart';

// 重置app配置
class ResetAppStateAction {
  late final Completer<bool> completer = Completer();
  // Response
  late bool result;

  ResetAppStateAction();
}

// 更新app配置
class UpdateAppConfig {
  final Completer<bool> completer = Completer();

  Langage? langage;
  String? themeColor;
  bool? firstRun;

  UpdateAppConfig({
    this.langage,
    this.themeColor,
    this.firstRun,
  });
}
