import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_local_data_source.dart';
import '../datasources/quote_remote_data_source.dart';
import '../models/quote_model.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;
  final QuoteLocalDataSource localDataSource;

  QuoteRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Quote> getRandomQuote() async {
    final remoteQuote = await remoteDataSource.getRandomQuote();
    final isFav = await localDataSource.isFavorite(remoteQuote.id);
    return remoteQuote.copyWith(isFavorite: isFav);
  }

  @override
  Future<List<Quote>> getFavoriteQuotes() async {
    return await localDataSource.getFavoriteQuotes();
  }

  @override
  Future<void> saveFavoriteQuote(Quote quote) async {
    final quoteModel = QuoteModel(
      id: quote.id,
      content: quote.content,
      author: quote.author,
      isFavorite: true,
    );
    await localDataSource.saveFavoriteQuote(quoteModel);
  }

  @override
  Future<void> removeFavoriteQuote(String id) async {
    await localDataSource.removeFavoriteQuote(id);
  }
}
