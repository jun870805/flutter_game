class Record {
  String? insertTime;
  int? point;
  int? rank;
  String? username;

  Record({
    this.insertTime,
    this.point,
    this.rank,
    this.username,
  });

  factory Record.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Record();
    return Record(
      insertTime: json['insert_time'],
      point: json['point'],
      rank: json['rank'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'insertTime': insertTime,
      'ipointd': point,
      'rank': rank,
      'username': username,
    };
  }
}
