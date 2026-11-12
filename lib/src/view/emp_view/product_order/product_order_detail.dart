import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/context_extension.dart';
import 'package:rust_flutter/widgets/custom_textfield.dart';
import '../../../../core/extension/text_style.dart';
import '../../../../features/products/model/product_model.dart';
import '../../../providers/order_provider.dart';

class ProductOrderDetail extends StatefulWidget {
  final String heroTag;
  final InventoryViewData invProData;

  const ProductOrderDetail({
    super.key,
    required this.heroTag,
    required this.invProData,
  });

  @override
  State<ProductOrderDetail> createState() => _ProductOrderDetailState();
}

class _ProductOrderDetailState extends State<ProductOrderDetail> {
  OrderProvider get _orderBasketPvd =>
      Provider.of<OrderProvider>(context, listen: false);

  final TextEditingController _txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _orderBasketPvd.initialize(
        id: widget.invProData.id ?? 0,
        count: 1,
        price: widget.invProData.price,
        orderName: widget.invProData.productName,
        orderNote: "",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderItem = context.select<OrderProvider, OrderItem?>((value) {
      return value.odItem;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: context.theme.primaryColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Hero(
                    tag: widget.heroTag,
                    child: Image.asset(
                      "assets/icons/burger.png",
                      width: 200,
                      height: 160,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 20)),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.invProData.productName,
                          style: getAppBarText(color: Colors.black),
                        ),
                        Text(
                          widget.invProData.price.toString(),
                          style: getAppBarText(color: Colors.black),
                        ),
                      ],
                    ),
                    TextFieldWidget(
                      text: "Note for Request",
                      controller: _txtController,
                      width: double.infinity,
                      onTap: () {},
                      onTapOutside: (v) {},
                      line: 3,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _orderBasketPvd.updateOrderItem(
                              orderItem!.count + 1,
                              widget.invProData.price * (orderItem.count + 1),
                            );
                          },
                          icon: Icon(
                            Icons.add_circle_outline_sharp,
                            color: context.theme.primaryColor,
                          ),
                        ),
                        Text(
                          "${orderItem?.count}",
                          style: getTitleText(
                            color: context.theme.primaryColor,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            orderItem!.count <= 0
                                ? null
                                : _orderBasketPvd.updateOrderItem(
                                  orderItem.count - 1,
                                  widget.invProData.price *
                                      (orderItem.count - 1),
                                );
                          },
                          icon: Icon(
                            Icons.remove_circle_outline_outlined,
                            color: context.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(child: const SizedBox(height: 120)),
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheet(
        enableDrag: false,
        constraints: BoxConstraints(minWidth: double.infinity),
        shadowColor: Colors.black,
        backgroundColor: const Color.fromARGB(221, 251, 251, 251),
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 40, // Pushes up above keyboard
            ),
            child: InkWell(
              onTap: () {
                _orderBasketPvd.odItem!.count < 0
                    ? null
                    : _orderBasketPvd.updateOrderBasket();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.indigo,
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Selector<OrderProvider, bool>(
                      builder: (context, load, chid) {
                        return load
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : Text(
                              orderItem?.count == 0
                                  ? "Remove from Basket"
                                  : "Add to Basket : ${orderItem?.price} (Incl. tax)",
                              style: getMediumtext(color: Colors.white),
                            );
                      },
                      selector: (cxt, pvd) {
                        return pvd.loading;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
