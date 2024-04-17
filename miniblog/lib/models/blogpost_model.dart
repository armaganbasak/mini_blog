import 'dart:convert';

class BlogpostModel {
  final String title;
  final String id;
  final String content;
  final String author;
  final String thumbnail;
  BlogpostModel({
    required this.title,
    required this.id,
    required this.content,
    required this.author,
    required this.thumbnail,
  });

  BlogpostModel copyWith({
    String? title,
    String? id,
    String? content,
    String? author,
    String? thumbnail,
  }) {
    return BlogpostModel(
      title: title ?? this.title,
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'content': content,
      'author': author,
      'thumbnail': thumbnail,
    };
  }

  factory BlogpostModel.fromMap(Map<String, dynamic> map) {
    return BlogpostModel(
      title: map['title'],
      id: map['id'],
      content: map['content'],
      author: map['author'],
      thumbnail: map['thumbnail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogpostModel.fromJson(String source) => BlogpostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BlogpostModel(title: $title, id: $id, content: $content, author: $author, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BlogpostModel &&
      other.title == title &&
      other.id == id &&
      other.content == content &&
      other.author == author &&
      other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      id.hashCode ^
      content.hashCode ^
      author.hashCode ^
      thumbnail.hashCode;
  }
}
