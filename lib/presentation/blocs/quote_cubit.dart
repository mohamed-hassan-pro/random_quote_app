import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/quote_repository.dart';
import 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final QuoteRepository repository;

  QuoteCubit({required this.repository}) : super(QuoteInitial());

  Future<void> getRandomQuote() async {
    emit(QuoteLoading());
    try {
      final quote = await repository.getRandomQuote();
      emit(QuoteLoaded(quote: quote));
    } catch (e) {
      emit(QuoteError(message: e.toString()));
    }
  }

  Future<void> toggleFavorite() async {
    final currentState = state;
    if (currentState is QuoteLoaded) {
      final updatedQuote = currentState.quote.copyWith(
        isFavorite: !currentState.quote.isFavorite,
      );

      try {
        if (updatedQuote.isFavorite) {
          await repository.saveFavoriteQuote(updatedQuote);
        } else {
          await repository.removeFavoriteQuote(updatedQuote.id);
        }
        emit(QuoteLoaded(quote: updatedQuote));
      } catch (e) {
        emit(QuoteError(message: 'Failed to update favorite status.'));
      }
    }
  }
}
