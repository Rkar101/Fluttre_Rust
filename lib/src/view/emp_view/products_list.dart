import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/text_style.dart';

import '../../../features/products/model/product_model.dart';
import '../../../features/shopdata/model/shopdata_model.dart';
import '../../providers/shop_provider.dart';
import '../../../routes/page_router.dart';
import '../../providers/order_provider.dart';

class EmployeeProductList extends StatefulWidget {
  final ResponseShopData? shopData;
  const EmployeeProductList({super.key, required this.shopData});

  @override
  State<EmployeeProductList> createState() => _EmployeeProductListState();
}

class _EmployeeProductListState extends State<EmployeeProductList> {
  ShopProvider get _shopPvd =>
      Provider.of<ShopProvider>(context, listen: false);

  OrderProvider get _orderBasketPvd =>
      Provider.of<OrderProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _shopPvd.fectchShopInventory(context, widget.shopData?.shopId ?? 0);
      await _orderBasketPvd.getDbOrderItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataList = context.select<ShopProvider, List<InventoryViewData>>(
      (pvd) => pvd.inventorydataUi,
    );

    final totalCount = context.select<OrderProvider, int>(
      (pvd) => pvd.totalCount,
    );

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _shopPvd.fectchShopInventory(
              context,
              widget.shopData?.shopId ?? 0,
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                centerTitle: false,
                leading: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.indigo),
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final double currentHeight = constraints.biggest.height;
                    final bool isCollapsed = currentHeight <= 90.0;

                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: isCollapsed ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          widget.shopData?.shopName ?? "",
                          style: getAppBarText(color: Colors.black),
                        ),
                      ),
                      background: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedOpacity(
                              duration: Duration(seconds: 1),
                              opacity: isCollapsed ? 0.0 : 1.0,
                              child: Center(
                                child: Image.asset(
                                  "assets/icons/burger.png",
                                  width: 200,
                                  height: 160,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text(
                              widget.shopData?.shopName ?? "",
                              style: getAppBarText(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                sliver: SliverGrid.builder(
                  itemCount: dataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    crossAxisCount: 2,
                    mainAxisExtent: 200, // Matched to collapsed height
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final isExpanded = _shopPvd.expandedIndex == index;
                    final invProData = dataList[index];
                    final cartOrder = _orderBasketPvd.checkCard(invProData);
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        _shopPvd.updateExpandedIndex(index);
                        await Future.delayed(Duration(milliseconds: 150)).then((
                          _,
                        ) {
                          _shopPvd.updateExpandedIndex(null);
                        });
                        if (!context.mounted) return;
                        context.push(
                          PageRouter.empProductOrder,
                          extra: {
                            'productData': invProData,
                            'imageKey':
                                "Image - "
                                "${invProData.id}",
                          },
                        );
                      },
                      child: AnimatedScale(
                        duration: Duration(milliseconds: 200),
                        scale: isExpanded ? 1.05 : 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        46,
                                        140,
                                        157,
                                        255,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Hero(
                                      tag:
                                          "Image - "
                                          "${invProData.id}",
                                      child: Image.asset(
                                        "assets/icons/burger.png",
                                        width: double.maxFinite,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () async {
                                        _shopPvd.updateExpandedIndex(index);
                                        await Future.delayed(
                                          Duration(milliseconds: 100),
                                        ).then((_) {
                                          _shopPvd.updateExpandedIndex(null);
                                        });
                                        if (!context.mounted) return;
                                        context.push(
                                          PageRouter.empProductOrder,
                                          extra: {
                                            'productData': invProData,
                                            'imageKey':
                                                "Image - "
                                                "${invProData.id}",
                                          },
                                        );
                                      },
                                      icon: CircleAvatar(
                                        radius: 12,
                                        backgroundColor:
                                            cartOrder == null
                                                ? Colors.indigoAccent
                                                : Colors.white,
                                        child:
                                            cartOrder == null
                                                ? Icon(
                                                  Icons.add,
                                                  size: 20,
                                                  color: Colors.white,
                                                )
                                                : Text(
                                                  cartOrder.item.count
                                                      .toString(),
                                                  style: getTitleText(
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                invProData.productName,
                                style: getMediumtext(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${invProData.price}",
                                style: getMediumtext(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 90)),
            ],
          ),
        ),
      ),
      bottomSheet:
          totalCount <= 0
              ? null
              : BottomSheet(
                enableDrag: false,
                constraints: BoxConstraints(minWidth: double.infinity),
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                onClosing: () {},
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 40,
                      left: 20,
                      right: 20, // Pushes up above keyboard
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        context.push(PageRouter.empProductCart);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.indigo,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Selector<
                          OrderProvider,
                          ({int count, double price})
                        >(
                          builder: (context, orderBasket, chid) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Basket : ${orderBasket.count} items",
                                  style: getMediumtext(color: Colors.white),
                                ),
                                Text(
                                  "${orderBasket.price} Ks",
                                  style: getMediumtext(color: Colors.white),
                                ),
                              ],
                            );
                          },
                          selector: (cxt, pvd) {
                            return (
                              count: pvd.totalCount,
                              price: pvd.totalPrice,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
