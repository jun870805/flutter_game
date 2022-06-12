class User {
  int? id;

  User({
    this.id,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) return User();
    return User(
      id: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
