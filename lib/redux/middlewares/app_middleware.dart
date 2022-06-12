import 'package:redux/redux.dart';

import '../actions/app_actions.dart';
import '../states/app_state.dart';
import './global_middleware.dart';
import './user_middleware.dart';

final List<Middleware<AppState>> appMiddlewares = [
  TypedMiddleware<AppState, ResetAppStateAction>(
      _createResetAppStateActionMiddleware()),
  ...createGlobalMiddleware(),
  ...createUserMiddleware()
];

Middleware<AppState> _createResetAppStateActionMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is! ResetAppStateAction) return;

    try {
      action.result = true;
      next(action);

      action.completer.complete(true);
    } catch (error) {
      action.completer.completeError(error);
    }
  };
}
