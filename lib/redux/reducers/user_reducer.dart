import 'package:redux/redux.dart';

import '../../includes.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UserLoginAction>(_userLogin),
  TypedReducer<UserState, UserLogoutAction>(_userLogout),
]);

UserState _userLogin(UserState state, UserLoginAction action) {
  state.currentUser = action.user;
  return state;
}

UserState _userLogout(UserState state, UserLogoutAction action) {
  state.currentUser = null;
  return state;
}
