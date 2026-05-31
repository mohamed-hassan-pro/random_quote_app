import 'package:flutter_test/flutter_test.dart';
import 'package:random_quote_app/data/models/quote_model.dart';

void main() {
  group('QuoteModel Tests', () {
    test('should convert from map, json, and to map correctly', () {
      final json = {
        '_id': '123',
        'content': 'Life is beautiful',
        'author': 'Unknown',
      };

      final model = QuoteModel.fromJson(json);
      expect(model.id, '123');
      expect(model.content, 'Life is beautiful');
      expect(model.author, 'Unknown');
      expect(model.isFavorite, false);

      final map = model.toJson();
      expect(map['id'], '123');
      expect(map['content'], 'Life is beautiful');
      expect(map['author'], 'Unknown');
      expect(map['isFavorite'], 0);

      final fromMap = QuoteModel.fromMap(map);
      expect(fromMap.id, model.id);
      expect(fromMap.content, model.content);
      expect(fromMap.author, model.author);
      expect(fromMap.isFavorite, model.isFavorite);
    });
  });
}
