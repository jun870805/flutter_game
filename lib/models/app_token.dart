class AppToken {
  String? token;

  AppToken({
    this.token,
  });

  factory AppToken.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AppToken();
    return AppToken(
      token: json['X-CSRFToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
