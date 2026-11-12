import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/context_extension.dart';
import 'package:rust_flutter/src/providers/product_provider.dart';

import '../../../../core/extension/text_style.dart';
import '../../../providers/admin_provider.dart';
import '../../../../features/products/model/product_model.dart';
import '../../../providers/shop_provider.dart';
import '../../../../widgets/custom_pop_up.dart';
import '../../../../widgets/custom_textfield.dart';

class InventoryStorePage extends StatefulWidget {
  final int shopId;
  const InventoryStorePage({super.key, required this.shopId});

  @override
  State<InventoryStorePage> createState() => _InventoryStorePageState();
}

class _InventoryStorePageState extends State<InventoryStorePage> {
  int _selectedIndex = 0; // Tracks the currently selected category index

  // final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productStock = TextEditingController();

  ProductProvider get productPvd =>
      Provider.of<ProductProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final adminPvd = Provider.of<AdminProvider>(context, listen: false);
      await adminPvd.getAdminCategory();
      await productPvd.getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = context.select<AdminProvider, List<Category>>((
      adminPvd,
    ) {
      return adminPvd.categories;
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory Store')),
      body: Consumer<AdminProvider>(
        builder: (context, adminPvd, child) {
          if (adminPvd.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Safety check if index out of bounds after fetch
          if (_selectedIndex >= adminPvd.categories.length) {
            _selectedIndex = 0;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  "Inventory Product Add",
                  style: getTitleText(color: Colors.black),
                ),
                Selector<
                  ProductProvider,
                  ({List<Product> prdList, Product? data})
                >(
                  builder: (_, prdPvd, _) {
                    return CustomPopUp(
                      text: 'Product',
                      width: double.maxFinite,
                      onSelected: (v) {
                        productPvd.updateSelectProduct(v);
                      },
                      selectedText: "${prdPvd.data?.name}",
                      itemBuilder: (BuildContext context) {
                        return prdPvd.prdList.map<PopupMenuEntry<Product>>((
                          data,
                        ) {
                          return PopupMenuItem(
                            value: data,
                            child: Row(
                              children: [Expanded(child: Text(data.name))],
                            ),
                          );
                        }).toList();
                      },
                    );
                  },
                  selector: (_, pvd) {
                    return (
                      prdList: pvd.productList,
                      data: pvd.selectedProduct,
                    );
                  },
                ),
                // TextFieldWidget(
                //   text: "Product Name",
                //   controller: _productName,
                //   width: context.width,
                //   onTap: () {},
                //   onTapOutside: (v) {
                //     FocusScope.of(context).unfocus();
                //   },
                //   line: 1,
                // ),
                CustomPopUp(
                  text: 'Category',
                  width: double.maxFinite,
                  onSelected: (v) {
                    adminPvd.selectCategory(v as Category);
                  },
                  selectedText: "${adminPvd.selectEd?.name}",
                  itemBuilder: (BuildContext context) {
                    return categoryList.map<PopupMenuEntry<Category>>((data) {
                      return PopupMenuItem(
                        value: data,
                        child: Row(
                          children: [Expanded(child: Text(data.name))],
                        ),
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
                      width: context.width * 0.6,
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
                      width: context.width * 0.3,
                      onTap: () {},
                      onTapOutside: (v) {
                        FocusScope.of(context).unfocus();
                      },
                      line: 1,
                    ),
                  ],
                ),
                Spacer(),

                Row(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          widget.shopId,
                          productPvd.selectedProduct!.productId,
                          productPvd.selectedProduct!.categoryId,
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
                const SizedBox(height: 30),

                // // 1. Horizontal Scrollable 2-Row Category Grid
                // Container(
                //   height: 160, // Controlled height for 2 rows of chips
                //   padding: const EdgeInsets.symmetric(vertical: 8),
                //   child: GridView.builder(
                //     scrollDirection: Axis.horizontal,
                //     padding: const EdgeInsets.symmetric(horizontal: 12),
                //     itemCount: adminPvd.categories.length,
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3, // 2 rows vertically
                //       mainAxisSpacing: 8,
                //       crossAxisSpacing: 8,
                //       childAspectRatio: 0.3, // Adjusts width-to-height ratio of chips
                //     ),
                //     itemBuilder: (context, index) {
                //       final category = adminPvd.categories[index];
                //       ChoiceChip; // hint fix
                //       final isSelected = _selectedIndex == index;

                //       return ChoiceChip(
                //         label: Text(
                //           category.name,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         selected: isSelected,
                //         onSelected: (selected) {
                //           setState(() {
                //             _selectedIndex = index;
                //           });
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
                //             color: isSelected ? Colors.transparent : Colors.grey.shade300,
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),

                // // 2. Dynamic Content Based on Selected Category

                // Expanded(
                //   child: ListView.builder(
                //     padding: const EdgeInsets.all(8.0),
                //     itemCount: 10, // Replace with selectedCategory.items.length
                //     itemBuilder: (context, index) {
                //       return Card(
                //         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                //         child: ListTile(
                //           leading: CircleAvatar(
                //             backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                //             child: Text('${index + 1}'),
                //           ),
                //           title: Text('${selectedCategory.name} Product $index'),
                //           subtitle: Text('Manage stock & details for product $index'),
                //           trailing: const Icon(Icons.chevron_right),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
