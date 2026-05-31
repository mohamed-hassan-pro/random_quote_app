import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final http.Client client;

  QuoteRemoteDataSourceImpl({required this.client});

  @override
  Future<QuoteModel> getRandomQuote() async {
    try {
      final response = await client.get(
        Uri.parse('https://api.allorigins.win/raw?url=https://zenquotes.io/api/random'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) {
          return QuoteModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: data[0]['q'] ?? '',
            author: data[0]['a'] ?? 'Unknown',
          );
        }
      }
    } catch (_) {
      // Fallback
    }

    try {
      final response = await client.get(
        Uri.parse('https://quote-garden.onrender.com/api/v3/quotes/random'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final quoteData = data['data']?[0];
        if (quoteData != null) {
          return QuoteModel(
            id: quoteData['_id'] ?? '',
            content: quoteData['quoteText'] ?? '',
            author: quoteData['quoteAuthor'] ?? 'Unknown',
          );
        }
      }
    } catch (_) {
      // Fallback
    }

    final localFallbacks = [
      {
        'id': '1',
        'content': 'The only way to do great work is to love what you do.',
        'author': 'Steve Jobs',
      },
      {
        'id': '2',
        'content': 'Believe you can and you\'re halfway there.',
        'author': 'Theodore Roosevelt',
      },
      {
        'id': '3',
        'content': 'It always seems impossible until it\'s done.',
        'author': 'Nelson Mandela',
      },
      {
        'id': '4',
        'content': 'Success is not final, failure is not fatal: it is the courage to continue that counts.',
        'author': 'Winston Churchill',
      },
      {
        'id': '5',
        'content': 'Act as if what you do makes a difference. It does.',
        'author': 'William James',
      }
    ];

    final randomItem = (localFallbacks..shuffle()).first;
    return QuoteModel.fromJson(randomItem);
  }
}
