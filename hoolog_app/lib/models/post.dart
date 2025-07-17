import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String content;
  final String author;
  final String date;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.content,
    required this.author,
    required this.date,
    required this.createdAt,
  });

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      content: map['content'] ?? '',
      author: map['author'] ?? '',
      date: map['date'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'author': author,
      'date': date,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'Post(id: $id, content: $content, author: $author, date: $date)';
  }
} 