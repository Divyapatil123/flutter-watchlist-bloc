import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/top_info_card.dart';

import '../bloc/watchlist_bloc.dart';
import '../widgets/watchlist_item.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08111F),
      body: SafeArea(
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is WatchlistError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            if (state is WatchlistLoaded) {
              final stocks = state.stocks;

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0F1B2D), Color(0xFF08111F)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Watchlist',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFF182538),
                              child: Icon(
                                Icons.show_chart_rounded,
                                color: Color(0xFF60A5FA),
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Track and reorder your favourite stocks easily.',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: TopInfoCard(
                                title: 'Total Stocks',
                                value: '${stocks.length}',
                                icon: Icons.stacked_line_chart_rounded,
                                iconColor: const Color(0xFF38BDF8),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TopInfoCard(
                                title: 'Movers',
                                value:
                                    '${stocks.where((e) => e.isPositive).length} Gainers',
                                icon: Icons.trending_up_rounded,
                                iconColor: const Color(0xFF34D399),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F1A2B),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFF1E2B3D),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFF17273C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.touch_app_rounded,
                              color: Color(0xFF93C5FD),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Hold and drag the handle to change stock positions in your watchlist.',
                              style: TextStyle(
                                fontSize: 13.5,
                                color: Color(0xFFD1D5DB),
                                height: 1.4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      padding: const EdgeInsets.only(bottom: 14),
                      itemCount: stocks.length,
                      onReorder: (oldIndex, newIndex) {
                        context.read<WatchlistBloc>().add(
                          ReorderWatchlist(
                            oldIndex: oldIndex,
                            newIndex: newIndex,
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        final stock = stocks[index];

                        return Container(
                          key: ValueKey(stock.symbol),
                          child: WatchlistItem(stock: stock, index: index),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
