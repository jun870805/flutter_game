import '../../includes.dart';

class UserState {
  User? currentUser;

  UserState({
    this.currentUser,
  });

  static UserState? fromJson(dynamic json) {
    if (json == null) return UserState();

    return UserState(
      currentUser: User.fromJson(json['currentUser']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentUser': currentUser?.toJson(),
    };
  }
}
