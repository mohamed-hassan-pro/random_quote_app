import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/quote.dart';
import '../blocs/quote_cubit.dart';

class QuoteActions extends StatelessWidget {
  final Quote quote;
  final VoidCallback onThemeChange;

  const QuoteActions({
    Key? key,
    required this.quote,
    required this.onThemeChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            quote.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: quote.isFavorite ? Colors.redAccent : Colors.white,
            size: 28.0,
          ),
          onPressed: () => context.read<QuoteCubit>().toggleFavorite(),
        ),
        IconButton(
          icon: const Icon(Icons.share_rounded, color: Colors.white, size: 28.0),
          onPressed: () => Share.share('"${quote.content}" - ${quote.author}'),
        ),
        IconButton(
          icon: const Icon(Icons.color_lens_rounded, color: Colors.white, size: 28.0),
          onPressed: onThemeChange,
        ),
        IconButton(
          icon: const Icon(Icons.autorenew_rounded, color: Colors.white, size: 28.0),
          onPressed: () => context.read<QuoteCubit>().getRandomQuote(),
        ),
      ],
    );
  }
}
