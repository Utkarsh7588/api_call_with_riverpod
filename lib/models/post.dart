import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
        body: body ??
            this.body, //?? returns expression on its left except whenit is null then it returns right value
        id: id ?? this.id,
        title: title ?? this.title,
        userId: userId ?? this.userId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        body: map['body'] as String,
        userId: map['userId'] as int,
        title: map['title'] as String,
        id: map['id'] as int);
  }
  String toJson() => json.encode(toMap());
  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
