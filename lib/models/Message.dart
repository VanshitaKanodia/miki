class Message {
  Message({
      required this.role,
      required this.content,});

  Message.fromJson(dynamic json) {
    role = json['role'];
    content = json['content'];
  }
  late String role;
  late String content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    return map;
  }

}