import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String id;
  final String content;
  final String author;
  final bool isFavorite;

  const Quote({
    required this.id,
    required this.content,
    required this.author,
    this.isFavorite = false,
  });

  Quote copyWith({
    String? id,
    String? content,
    String? author,
    bool? isFavorite,
  }) {
    return Quote(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, content, author, isFavorite];
}
