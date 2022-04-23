class User {
  int? id;
  String? phone;
  String? email;
  String? idName;
  String? idNo;
  String? code;

  String get maskedEmail {
    if (email != null) {
      return email!.replaceRange(0, 4, '****');
    }
    return '';
  }

  String get maskedPhone {
    if (phone != null) {
      return phone!.replaceRange(0, 4, '****');
    }
    return '';
  }

  User({
    this.id,
    this.phone,
    this.email,
    this.idName,
    this.idNo,
    this.code,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) return User();
    return User(
      id: json['id'] ?? json['X-User-Id'],
      phone: json['phone'],
      email: json['email'],
      idName: json['idName'],
      idNo: json['idNo'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'idName': idName,
      'idNo': idNo,
      'code': code,
    };
  }
}
