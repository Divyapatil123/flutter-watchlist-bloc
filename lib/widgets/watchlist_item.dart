import 'package:flutter/material.dart';
import '../models/stock.dart';

class WatchlistItem extends StatefulWidget {
  final Stock stock;
  final int index;

  const WatchlistItem({super.key, required this.stock, required this.index});

  @override
  State<WatchlistItem> createState() => _StockTileState();
}

class _StockTileState extends State<WatchlistItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final stock = widget.stock;
    final isPositive = stock.isPositive;

    final Color cardColor = const Color(0xFF0D1726);
    final Color borderColor = const Color(0xFF1C2A3D);

    final Color avatarBg = isPositive
        ? const Color(0xFF0F3D2E)
        : const Color(0xFF4C1D1D);

    final Color avatarText = isPositive
        ? const Color(0xFF34D399)
        : const Color(0xFFF87171);

    final Color changeBg = isPositive
        ? const Color(0xFF0B3B2E)
        : const Color(0xFF3F1D1D);

    final Color changeText = isPositive
        ? const Color(0xFF34D399)
        : const Color(0xFFF87171);

    final String sign = isPositive ? '+' : '';

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),

      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),

          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: avatarBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  stock.symbol.substring(0, 1),
                  style: TextStyle(
                    color: avatarText,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      stock.companyName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${stock.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: changeBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$sign${stock.change.toStringAsFixed(2)}  '
                      '$sign${stock.changePercent.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: changeText,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF334155), width: 1),
                ),
                child: ReorderableDragStartListener(
                  index: widget.index,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.drag_indicator_rounded,
                      color: Color(0xFFCBD5E1),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
