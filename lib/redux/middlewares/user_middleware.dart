import 'package:redux/redux.dart';

import '../../includes.dart';

List<Middleware<AppState>> createUserMiddleware() {
  return [
    TypedMiddleware<AppState, UserLoginAction>(_createUserLogInMiddleware()),
    TypedMiddleware<AppState, UserLogoutAction>(_createUserLogOutMiddleware()),
  ];
}

Middleware<AppState> _createUserLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is! UserLoginAction) return;

    try {
      Result<dynamic> userLoginResult;
      Result<dynamic> userCenterResult;
      User user;

      userLoginResult = await sharedApiClient.user.login(
        username: action.username ?? '',
        password: action.password ?? '',
      );

      // 登入成功後取得資料
      // if (userLoginResult.success) {
      //   userCenterResult = await sharedApiClient.user.userCenter();
      //   user = userCenterResult.data;
      // } else {
      //   throw Exception(userLoginResult.msg);
      // }

      // action.result = userCenterResult;
      // action.user = user;
      next(action);

      action.completer.complete(userLoginResult);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}

Middleware<AppState> _createUserLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is! UserLogoutAction) return;

    try {
      // Result<dynamic> userLogoutResult;
      // try {
      //   userLogoutResult = await sharedApiClient.user.logout();
      // } catch (e) {
      //   throw Exception(e);
      // }

      // action.result = userLogoutResult;
      next(action);

      store.dispatch(ResetAppStateAction());

      // action.completer.complete(userLogoutResult);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
