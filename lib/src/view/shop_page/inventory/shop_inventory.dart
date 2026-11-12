import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/context_extension.dart';
import 'package:rust_flutter/core/extension/text_style.dart';
import 'package:rust_flutter/widgets/custom_pop_up.dart';
import 'package:rust_flutter/widgets/custom_textfield.dart';

import '../../../providers/admin_provider.dart';
import '../../../../features/products/model/product_model.dart';
import '../../../../features/shopdata/model/shopdata_model.dart';
import '../../../providers/shop_provider.dart';
import '../../../../routes/page_router.dart';

class ShopInventory extends StatefulWidget {
  final ResponseShopData shopData;
  const ShopInventory({super.key, required this.shopData});

  @override
  State<ShopInventory> createState() => _ShopInventoryState();
}

class _ShopInventoryState extends State<ShopInventory> {
  // final TextEditingController _productName = TextEditingController();
  // final TextEditingController _productPrice = TextEditingController();
  // final TextEditingController _productStock = TextEditingController();

  ShopProvider get _shopPvd =>
      Provider.of<ShopProvider>(context, listen: false);

  AdminProvider get adminPvd =>
      Provider.of<AdminProvider>(context, listen: false);

  int stock = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _shopPvd.fectchShopInventory(context, widget.shopData.shopId ?? 0);
      if (!mounted) return;
      await _shopPvd.fectchShopProducts(context, widget.shopData);

      await adminPvd.getAdminCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventoryList = context.select<ShopProvider, List<InventoryViewData>>(
      (shopPvd) {
        return shopPvd.inventorydataUi;
      },
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.shopData.shopName.toString())),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: AnimatedScale(
        scale: 1.0, // Scales down to 0 (hidden) or 1 (visible)
        duration: const Duration(milliseconds: 300), // Smooth transition speed
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: 1.0, // Fades out completely
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton(
            heroTag: "add",
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return InventoryAddDialog(
              //       productName: _productName,
              //       productPrice: _productPrice,
              //       productStock: _productStock,
              //       productId: 0,
              //       categoryId: 0,
              //       shopId: widget.shopData.shopId ?? 0,
              //       categoryList: categoryList,
              //     );
              //   },
              // );
              context.push(
                PageRouter.addShopInventory,
                extra: widget.shopData.shopId,
              );
            },
            child: const Icon(Icons.add, size: 35),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 150,
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: GridView.builder(
            //     scrollDirection: Axis.horizontal,
            //     //  padding: const EdgeInsets.symmetric(horizontal: 12),
            //     itemCount: categoryList.length,
            //     gridDelegate:
            //         const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 3, // 2 rows vertically
            //           mainAxisSpacing: 2,
            //           crossAxisSpacing: 2,
            //           childAspectRatio:
            //               0.35, // Adjusts width-to-height ratio of chips
            //         ),
            //     itemBuilder: (context, index) {
            //       final category = categoryList[index];
            //       final isSelected = isSelect == index;
            //       return ChoiceChip(
            //         label: Text(
            //           category.name,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         selected: isSelected,
            //         onSelected: (selected) {
            //           _shopPvd.updateSelectedCategory(index);
            //         },
            //         selectedColor: Theme.of(context).primaryColor,
            //         labelStyle: TextStyle(
            //           color: isSelected ? Colors.white : Colors.black87,
            //           fontWeight: FontWeight.w600,
            //           fontSize: 12,
            //         ),
            //         backgroundColor: Colors.grey.shade100,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //           side: BorderSide(
            //             color:
            //                 isSelected
            //                     ? Colors.transparent
            //                     : Colors.grey.shade300,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // inventoryList.isNotEmpty
            //     ? Expanded(
            //       child: ListView.builder(
            //         padding: const EdgeInsets.all(8.0),
            //         itemCount: productList.length,
            //         itemBuilder: (context, index) {
            //           final data = productList[index];
            //           return Card(
            //             child: ListTile(
            //               title: Row(
            //                 mainAxisAlignment:
            //                     MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(data.name),
            //                   TextButton(
            //                     onPressed: () {
            //                       _productName.text = data.name;

            //                       showDialog(
            //                         context: context,
            //                         builder: (context) {
            //                           return InventoryAddDialog(
            //                             productName: _productName,
            //                             productPrice: _productPrice,
            //                             productStock: _productStock,
            //                             productId: data.productId,
            //                             categoryId: data.categoryId,
            //                             shopId:
            //                                 widget.shopData.shopId ?? 0,
            //                           );
            //                         },
            //                       );
            //                     },
            //                     child: Text("Add"),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     )
            //     :
            Expanded(
              child: ListView.builder(
                itemCount: inventoryList.length,
                itemBuilder: (context, index) {
                  log("Inventory Data Have :::: ");
                  final data = inventoryList[index];

                  log("Image URL ::: ${data.imageUrl}");
                  return inventoryList.isNotEmpty
                      ? Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(120, 158, 158, 158),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  width: 50,
                                  height: 60,
                                  fit: BoxFit.fill,
                                  imageUrl: data.imageUrl ?? "",
                                  progressIndicatorBuilder: (
                                    context,
                                    url,
                                    progress,
                                  ) {
                                    // 2. Return a lightweight widget placeholder while loading
                                    return const SizedBox(
                                      width: 50,
                                      height: 60,
                                      child: Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 0.3,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      "assets/icons/fail_image.png",
                                      width: 50,
                                      height: 60,
                                    );
                                  },
                                ),
                              ),
                              title: Text(data.productName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price : ${data.price}'),
                                  Text('Stock : ${data.quantity}'),
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      : Expanded(child: Text("Empty Inventory"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryAddDialog extends StatelessWidget {
  const InventoryAddDialog({
    super.key,
    required TextEditingController productName,
    required TextEditingController productPrice,
    required TextEditingController productStock,
    required this.productId,
    required this.categoryId,
    required this.shopId,
    required this.categoryList,
  }) : _productName = productName,
       _productPrice = productPrice,
       _productStock = productStock;

  final TextEditingController _productName;
  final TextEditingController _productPrice;
  final TextEditingController _productStock;
  final int productId;
  final int categoryId;
  final int shopId;
  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: context.width * 0.85,
        height: context.height * 0.55, // Set your desired height here
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            spacing: 15,
            children: [
              const SizedBox(height: 15),
              Text(
                "Inventory Product Add",
                style: getTitleText(color: Colors.black),
              ),
              TextFieldWidget(
                text: "Product Name",
                controller: _productName,
                width: context.width * 0.7,
                onTap: () {},
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                line: 1,
              ),
              CustomPopUp(
                text: 'Category',
                width: double.maxFinite,
                onSelected: (v) {},
                selectedText: "",
                itemBuilder: (BuildContext context) {
                  return categoryList.map<PopupMenuEntry<Category>>((data) {
                    return PopupMenuItem(
                      value: data,
                      child: Row(children: [Expanded(child: Text(data.name))]),
                    );
                  }).toList();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWidget(
                    text: "Product Price",
                    keyboardType: TextInputType.number,

                    controller: _productPrice,
                    width: context.width * 0.4,
                    onTap: () {},
                    onTapOutside: (v) {
                      FocusScope.of(context).unfocus();
                    },
                    line: 1,
                  ),
                  TextFieldWidget(
                    text: "Stock",
                    keyboardType: TextInputType.number,
                    controller: _productStock,
                    width: context.width * 0.25,
                    onTap: () {},
                    onTapOutside: (v) {
                      FocusScope.of(context).unfocus();
                    },
                    line: 1,
                  ),
                ],
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
                      final quantity = int.tryParse(_productStock.text);
                      final price = int.tryParse(_productPrice.text);
                      context.read<ShopProvider>().addProductInventory(
                        context,
                        shopId,
                        productId,
                        categoryId,
                        price ?? 0,
                        quantity ?? 0,
                      );
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.indigo),
                    ),
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
