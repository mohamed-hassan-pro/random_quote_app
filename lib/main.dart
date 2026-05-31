import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/quote_local_data_source.dart';
import 'data/datasources/quote_remote_data_source.dart';
import 'data/repositories/quote_repository_impl.dart';
import 'presentation/blocs/favorites_cubit.dart';
import 'presentation/blocs/quote_cubit.dart';
import 'presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final remoteDataSource = QuoteRemoteDataSourceImpl(client: http.Client());
  final localDataSource = QuoteLocalDataSourceImpl();
  final repository = QuoteRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final QuoteRepositoryImpl repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuoteCubit(repository: repository)..getRandomQuote(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(repository: repository),
        ),
      ],
      child: MaterialApp(
        title: 'Inspirational Quotes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Roboto',
        ),
        home: const HomePage(),
      ),
    );
  }
}
