import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String symbol;
  final String companyName;
  final double price;
  final double change;
  final double changePercent;

  const Stock({
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.change,
    required this.changePercent,
  });
  

  bool get isPositive => change >= 0;

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      companyName: json['companyName'],
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'companyName': companyName,
      'price': price,
      'change': change,
      'changePercent': changePercent,
    };
  }

  @override
  List<Object?> get props => [
        symbol,
        companyName,
        price,
        change,
        changePercent,
      ];
}