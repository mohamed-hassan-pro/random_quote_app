import '../entities/quote.dart';

abstract class QuoteRepository {
  Future<Quote> getRandomQuote();
  Future<List<Quote>> getFavoriteQuotes();
  Future<void> saveFavoriteQuote(Quote quote);
  Future<void> removeFavoriteQuote(String id);
}
