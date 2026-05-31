import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';

class FavoritesCubit extends Cubit<List<Quote>> {
  final QuoteRepository repository;

  FavoritesCubit({required this.repository}) : super([]);

  Future<void> loadFavorites() async {
    try {
      final favorites = await repository.getFavoriteQuotes();
      emit(favorites);
    } catch (_) {
      emit([]);
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await repository.removeFavoriteQuote(id);
      loadFavorites();
    } catch (_) {}
  }
}
