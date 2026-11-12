import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/context_extension.dart';
import 'package:rust_flutter/core/extension/text_style.dart';
import 'package:rust_flutter/features/shopdata/model/shopdata_model.dart';
import 'package:rust_flutter/src/providers/shop_provider.dart';
import 'package:rust_flutter/routes/page_router.dart';
import 'package:rust_flutter/src/enums/emp_role.dart';

import '../../../widgets/custom_textfield.dart';

class ShopListView extends StatefulWidget {
  const ShopListView({super.key});

  @override
  State<ShopListView> createState() => _ShopListViewState();
}

class _ShopListViewState extends State<ShopListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ShopProvider get _shopPvd =>
      Provider.of<ShopProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _shopPvd.getData();
      await _shopPvd.getShopList();
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    // Start the animation automatically when the screen loads
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = context.watch<ShopProvider>().isVisible;
    return Scaffold(
      appBar: commonAppBar(color: Colors.white, text: "Shops"),

      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: AnimatedScale(
        scale: (isVisible && _shopPvd.empRole != AuthRole.employee) ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton(
            heroTag: "shop detail",
            onPressed: () {
              context.push(PageRouter.shopDetailPage);
            },
            child: const Icon(Icons.add_home_work_outlined, size: 25),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Selector<ShopProvider, List<ResponseShopData>>(
          builder: (_, shopList, _) {
            return _shopPvd.empRole == AuthRole.employee
                ? GridView.builder(
                  itemCount: shopList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    mainAxisExtent: 120,
                  ),
                  itemBuilder: (context, dindex) {
                    final shopData = shopList[dindex];

                    return InkWell(
                      onTap: () {
                        context.push(PageRouter.empProducts, extra: shopData);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icons/store.png",
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              shopData.shopName ?? " Fail Name ",
                              style: getTitleText(color: Colors.black),
                            ),

                            // Text(
                            //   "address - ${shopData.address ?? " Fail Address "}",
                            //   style: getMediumtext(
                            //     fontSize: 14,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                : ListView.builder(
                  itemCount: shopList.length,
                  itemBuilder: (context, index) {
                    final double start = (index * 0.1).clamp(0.0, 1.0);
                    final double end = (start + 0.4).clamp(0.0, 1.0);
                    final isPressed = _shopPvd.expandedIndex == index;
                    final Animation<double> animation = CurvedAnimation(
                      parent: _controller,
                      curve: Interval(start, end, curve: Curves.easeInCubic),
                    );
                    final shopData = shopList[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),

                      onTap: () async {
                        _shopPvd.updateExpandedIndex(index);
                        await Future.delayed(Duration(milliseconds: 100)).then((
                          _,
                        ) {
                          _shopPvd.updateExpandedIndex(null);
                          Future.delayed(Duration(milliseconds: 100)).then((_) {
                            if (!context.mounted) return;
                            context.push(
                              PageRouter.shopInventory,
                              extra: shopData,
                            );
                          });
                        });
                      },
                      child: FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(
                              0,
                              0.3,
                            ), // Slides up from slightly below
                            end: Offset.zero,
                          ).animate(animation),
                          child: AnimatedScale(
                            scale:
                                isPressed
                                    ? 1.05
                                    : 1.0, // Scales up when pressed down
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceInOut,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shopData.shopName ?? " Fail Name ",
                                        style: getTitleText(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "contact - ${shopData.contact ?? " Fail Contact "}",
                                        style: getMediumtext(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "address - ${shopData.address ?? " Fail Address "}",
                                        style: getMediumtext(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible:
                                        _shopPvd.empRole != AuthRole.employee,
                                    child: IconButton(
                                      onPressed: () {
                                        log("${shopData.contactLink}");
                                        context.push(
                                          PageRouter.shopDetailPage,
                                          extra: shopData,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
          },
          selector: (_, shopPvd) => shopPvd.shopList,
        ),
      ),
    );
  }
}

class ShopDataEdit extends StatelessWidget {
  const ShopDataEdit({
    super.key,
    required TextEditingController shopName,
    required TextEditingController shopContact,
    required TextEditingController shopLink,
    required this.shopId,
    required TextEditingController shopAddress,
  }) : _shopName = shopName,
       _shopContact = shopContact,
       _shopLink = shopLink,
       _shopAddress = shopAddress;

  final TextEditingController _shopName;
  final TextEditingController _shopContact;
  final TextEditingController _shopLink;
  final TextEditingController _shopAddress;
  final int shopId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: context.width * 0.85,
        height: context.height * 0.7, // Set your desired height here
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              const SizedBox(height: 10),
              Text("Edit Shop", style: getTitleText(color: Colors.black)),
              TextFieldWidget(
                text: "Shop Name",
                controller: _shopName,
                width: context.width,
                onTap: () {},
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                line: 1,
              ),

              TextFieldWidget(
                text: "Shop Address",
                controller: _shopAddress,
                width: context.width,
                onTap: () {},
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                line: 1,
              ),

              TextFieldWidget(
                text: "Shop Contact",

                controller: _shopContact,
                width: context.width,
                onTap: () {},
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                line: 1,
              ),

              TextFieldWidget(
                text: "Shop Link",
                controller: _shopLink,
                width: context.width,
                onTap: () {},
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                line: 1,
              ),

              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      "cancel",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final shopData = ResponseShopData(
                        shopId,
                        _shopName.text,
                        _shopContact.text,
                        _shopAddress.text,
                        _shopLink.text,
                        true,
                      );
                      context.read<ShopProvider>().editShop(context, shopData);
                    },
                    child: Text("Edit", style: TextStyle(color: Colors.indigo)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
