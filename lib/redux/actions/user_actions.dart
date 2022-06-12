import 'dart:async';

import '../../includes.dart';

// 登入使用者
class UserLoginAction {
  late final Completer<Result<dynamic>> completer = Completer();

  final String? username;
  final String? password;
  // Response
  late User user;
  late Result result;

  UserLoginAction({
    this.username,
    this.password,
  });
}

class UserLogoutAction {
  final Completer<Result> completer = Completer();
  // Response
  late Result result;
}
