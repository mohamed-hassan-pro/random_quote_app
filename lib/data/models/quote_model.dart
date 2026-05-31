import '../../domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    required String id,
    required String content,
    required String author,
    bool isFavorite = false,
  }) : super(id: id, content: content, author: author, isFavorite: isFavorite);

  factory QuoteModel.fromJson(Map<String, dynamic> json, {bool isFavorite = false}) {
    return QuoteModel(
      id: json['_id'] ?? json['id'] ?? json['content']?.hashCode.toString() ?? '',
      content: json['content'] ?? json['quote'] ?? '',
      author: json['author'] ?? 'Unknown',
      isFavorite: isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      id: map['id']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      author: map['author']?.toString() ?? '',
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
