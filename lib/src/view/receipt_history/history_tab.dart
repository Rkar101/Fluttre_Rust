import 'package:flutter/material.dart';

class ReceiptHistoryView extends StatefulWidget {
  const ReceiptHistoryView({super.key});

  @override
  State<ReceiptHistoryView> createState() => _ReceiptHistoryViewState();
}

class _ReceiptHistoryViewState extends State<ReceiptHistoryView> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Custom Animated Item',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.expand_more),
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 12),
              const Text(
                'This content appears smoothly when toggled. You can put any complex widget tree here.',
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
