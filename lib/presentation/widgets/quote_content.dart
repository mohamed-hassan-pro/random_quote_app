import 'package:flutter/material.dart';
import '../../domain/entities/quote.dart';

class QuoteContent extends StatelessWidget {
  final Quote quote;

  const QuoteContent({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.format_quote_rounded,
          size: 48.0,
          color: Colors.white70,
        ),
        const SizedBox(height: 12.0),
        Text(
          '"${quote.content}"',
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.4,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 2.0,
              width: 24.0,
              color: Colors.white50,
            ),
            const SizedBox(width: 8.0),
            Text(
              quote.author,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
