import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/context_extension.dart';
import 'package:rust_flutter/core/extension/text_style.dart';

import '../../providers/order_provider.dart';

class OrderCart extends StatefulWidget {
  const OrderCart({super.key});

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart>
    with SingleTickerProviderStateMixin {
  OrderProvider get _orderBasketPvd =>
      Provider.of<OrderProvider>(context, listen: false);

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _orderBasketPvd.getDbOrderItem();
    });
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(text: "Cart", color: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Summary",
                    style: getTitleText(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Add Items",
                    style: getAppBarText(color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverList.builder(
              itemCount: _orderBasketPvd.orderBasket.length,
              itemBuilder: (context, ind) {
                final double start = (ind * 0.1).clamp(0.0, 1.0);
                final double end = (start + 0.4).clamp(0.0, 1.0);
                final data = _orderBasketPvd.orderBasket[ind];
                final animation = CurvedAnimation(
                  parent: _controller,
                  curve: Interval(start, end, curve: Curves.bounceInOut),
                );
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(
                        0,
                        1,
                      ), // Slides up from slightly below
                      end: Offset.zero,
                    ).animate(animation),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.orderName}",
                                style: getMediumtext(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Edit",
                                  style: getMediumtext(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                data.price.toStringAsFixed(2),
                                style: getMediumtext(color: Colors.black),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: context.primaryColor,
                                  ),
                                ),
                                child: Text(
                                  "${data.count}",
                                  style: getMediumtext(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal :",
                        style: getMediumtext(color: Colors.black),
                      ),
                      Text(
                        "Ks ${_orderBasketPvd.totalPrice.toStringAsFixed(2)}",
                        style: getMediumtext(color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery fee",
                        style: getMediumtext(color: Colors.black),
                      ),
                      Text("0.00", style: getMediumtext(color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location ",
                        style: getTitleText(color: Colors.black, fontSize: 16),
                      ),
                      Icon(Icons.edit_location_outlined),
                    ],
                  ),
                  Text(""),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                spacing: 25,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment details",
                        style: getTitleText(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        "See all",
                        style: getTitleText(color: Colors.blue, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 15,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage("assets/icons/credit-card.png"),
                            color: const Color.fromARGB(255, 44, 59, 140),
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Text("Card", style: getTitleText(color: Colors.black)),
                      Spacer(),
                      Radio(value: () {}, groupValue: null, onChanged: (v) {}),
                    ],
                  ),
                  Row(
                    spacing: 15,
                    children: [
                      CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage("assets/icons/banknote.png"),
                            color: const Color.fromARGB(255, 44, 59, 140),
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Text("Cash", style: getTitleText(color: Colors.black)),
                      Spacer(),
                      Radio(value: 1, groupValue: 1, onChanged: (v) {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
