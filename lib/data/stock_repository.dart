import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/stock.dart';

class StockRepository {
  static const String watchlistKey = 'saved_watchlist';

  final List<Stock> _defaultStocks = const [
    Stock(
      symbol: 'AAPL',
      companyName: 'Apple Inc.',
      price: 187.42,
      change: 2.14,
      changePercent: 1.16,
    ),
    Stock(
      symbol: 'TSLA',
      companyName: 'Tesla Inc.',
      price: 171.89,
      change: -3.42,
      changePercent: -1.95,
    ),
    Stock(
      symbol: 'NVDA',
      companyName: 'NVIDIA Corp.',
      price: 903.56,
      change: 12.37,
      changePercent: 1.39,
    ),
    Stock(
      symbol: 'AMZN',
      companyName: 'Amazon',
      price: 178.75,
      change: -1.24,
      changePercent: -0.69,
    ),
    Stock(
      symbol: 'MSFT',
      companyName: 'Microsoft',
      price: 421.31,
      change: 4.11,
      changePercent: 0.99,
    ),
    Stock(
      symbol: 'GOOGL',
      companyName: 'Alphabet',
      price: 152.44,
      change: 0.84,
      changePercent: 0.55,
    ),
  ];

  Future<List<Stock>> getWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList(watchlistKey);

    if (savedData == null || savedData.isEmpty) {
      return _defaultStocks;
    }

    return savedData
        .map((item) => Stock.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> saveWatchlist(List<Stock> stocks) async {
    final prefs = await SharedPreferences.getInstance();
    final data = stocks.map((stock) => jsonEncode(stock.toJson())).toList();
    await prefs.setStringList(watchlistKey, data);
  }
}