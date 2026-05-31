import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/quote_cubit.dart';
import '../blocs/quote_state.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/quote_actions.dart';
import '../widgets/quote_content.dart';
import '../widgets/theme_background.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _themeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Inspirations', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmarks_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesPage()),
            ),
          ),
        ],
      ),
      body: ThemeBackground(
        themeIndex: _themeIndex,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: BlocBuilder<QuoteCubit, QuoteState>(
              builder: (context, state) {
                if (state is QuoteLoading) {
                  return const CircularProgressIndicator(color: Colors.white);
                } else if (state is QuoteLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GlassmorphicCard(
                        child: QuoteContent(quote: state.quote),
                      ),
                      const SizedBox(height: 32.0),
                      QuoteActions(
                        quote: state.quote,
                        onThemeChange: () => setState(() => _themeIndex++),
                      ),
                    ],
                  );
                } else if (state is QuoteError) {
                  return Text(state.message, style: const TextStyle(color: Colors.white));
                }
                return const Text('Tap refresh to fetch a quote!', style: TextStyle(color: Colors.white));
              },
            ),
          ),
        ),
      ),
    );
  }
}
