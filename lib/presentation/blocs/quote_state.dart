import 'package:equatable/equatable.dart';
import '../../domain/entities/quote.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object?> get props => [];
}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded({required this.quote});

  @override
  List<Object?> get props => [quote];
}

class QuoteError extends QuoteState {
  final String message;

  const QuoteError({required this.message});

  @override
  List<Object?> get props => [message];
}
