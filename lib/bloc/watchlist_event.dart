part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {}

class LoadWatchlist extends WatchlistEvent {}

class ReorderWatchlist extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderWatchlist({
    required this.oldIndex,
    required this.newIndex,
  });
}