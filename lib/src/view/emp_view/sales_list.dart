import 'package:flutter/material.dart';
import 'package:rust_flutter/core/extension/text_style.dart';

class SalesList extends StatefulWidget {
  const SalesList({super.key});

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    // Start the animation automatically when the screen loads
    _controller.forward();
  }

  int items = 5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        color: Colors.white,
        text: "Page-Load Entry Animation",
      ),
      body: ListView.builder(
        itemCount: items,
        itemBuilder: (context, index) {
          // Calculate a unique time window for each item based on its index
          final double start = (index * 0.1).clamp(0.0, 1.0);
          final double end = (start + 0.4).clamp(0.0, 1.0);

          final Animation<double> animation = CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3), // Slides up from slightly below
                end: Offset.zero,
              ).animate(animation),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text('$index')),
                  title: Text('List Item Number $index'),
                  subtitle: const Text('Fades and slides in sequentially'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
