import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/watchlist_bloc.dart';
import 'data/stock_repository.dart';
import 'screens/watchlist_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => StockRepository(),
      child: BlocProvider(
        create: (context) => WatchlistBloc(
          repository: context.read<StockRepository>(),
        )..add(LoadWatchlist()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '021 Trade Watchlist',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF0F172A),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: const WatchlistScreen(),
        ),
      ),
    );
  }
}