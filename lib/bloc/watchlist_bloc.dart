import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/stock_repository.dart';
import '../models/stock.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final StockRepository repository;

  WatchlistBloc({required this.repository}) : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ReorderWatchlist>(_onReorderWatchlist);
  }

  Future<void> _onLoadWatchlist(
    LoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());

    try {
      final stocks = await repository.getWatchlist();
      emit(WatchlistLoaded(stocks));
    } catch (e) {
      emit(WatchlistError('Failed to load watchlist'));
    }
  }

  Future<void> _onReorderWatchlist(
    ReorderWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    if (state is! WatchlistLoaded) return;

    final currentState = state as WatchlistLoaded;
    final updatedList = List<Stock>.from(currentState.stocks);

    int newIndex = event.newIndex;

    if (event.oldIndex < newIndex) {
      newIndex -= 1;
    }

    final movedItem = updatedList.removeAt(event.oldIndex);
    updatedList.insert(newIndex, movedItem);

    await repository.saveWatchlist(updatedList);
    emit(WatchlistLoaded(updatedList));
  }
}