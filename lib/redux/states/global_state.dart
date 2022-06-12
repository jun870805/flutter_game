class GlobalState {
  GlobalState();

  static GlobalState? fromJson(dynamic json) {
    if (json == null) return GlobalState();

    return GlobalState();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
