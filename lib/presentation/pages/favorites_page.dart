import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/favorites_cubit.dart';
import '../widgets/theme_background.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Saved Inspirations', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ThemeBackground(
        themeIndex: 4, // Midnight theme
        child: BlocBuilder<FavoritesCubit, List>(
          builder: (context, favorites) {
            if (favorites.isEmpty) {
              return const Center(
                child: Text('No saved quotes yet.', style: TextStyle(color: Colors.white70, fontSize: 18.0)),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 80.0, left: 16.0, right: 16.0, bottom: 16.0),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final quote = favorites[index];
                return Card(
                  color: Colors.white.withOpacity(0.12),
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    title: Text(
                      '"${quote.content}"',
                      style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('- ${quote.author}', style: const TextStyle(color: Colors.white70)),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                      onPressed: () => context.read<FavoritesCubit>().removeFavorite(quote.id),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
