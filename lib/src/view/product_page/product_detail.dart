import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/text_style.dart';
import 'package:rust_flutter/src/providers/admin_provider.dart';
import 'package:rust_flutter/features/products/model/product_model.dart';
import 'package:rust_flutter/widgets/custom_pop_up.dart';
import 'package:rust_flutter/widgets/custom_textfield.dart';

import '../../providers/product_provider.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final TextEditingController _productName = TextEditingController();

  ProductProvider get productPvd =>
      Provider.of<ProductProvider>(context, listen: false);

  AdminProvider get adminPvd =>
      Provider.of<AdminProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await adminPvd.getAdminCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = context.select<ProductProvider, Category?>((productPvd) {
      return productPvd.selectedCategory;
    });

    final selectCateInd = context.select<AdminProvider, int>((adminPvd) {
      return adminPvd.selectedIndex;
    });

    final selectCateory = context.select<AdminProvider, Category?>((adminPvd) {
      return adminPvd.selectedCategory;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: getAppBarText(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "product",
        onPressed: () {
          showDialog(
            context: context,
            builder: (cxt) {
              return Dialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      spacing: 15,
                      children: [
                        Text(
                          "New Product",
                          style: getAppBarText(color: Colors.black),
                        ),

                        TextFieldWidget(
                          text: "Product Name",
                          controller: _productName,
                          width: double.infinity,
                          onTap: () {},
                          onTapOutside: (v) {
                            FocusScope.of(context).unfocus();
                          },
                          line: 1,
                        ),

                        Selector<ProductProvider, Category?>(
                          builder: (_, pvdCat, _) {
                            return CustomPopUp(
                              text: "Category",
                              width: double.infinity,
                              onSelected: (v) {
                                productPvd.updateProductCategory(v);
                              },
                              selectedText: pvdCat?.name ?? "",
                              itemBuilder: (BuildContext context) {
                                return adminPvd.categories
                                    .map<PopupMenuEntry<Category>>((data) {
                                      return PopupMenuItem(
                                        value: data,
                                        child: Row(
                                          children: [
                                            Expanded(child: Text(data.name)),
                                          ],
                                        ),
                                      );
                                    })
                                    .toList();
                              },
                            );
                          },
                          selector: (_, pvd) {
                            return pvd.selectedCategory;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                context.pop();
                              },
                              child: Text(
                                "cancel",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await productPvd.createProduct(
                                  context,
                                  1,
                                  _productName.text,
                                  category?.categoryId ?? 0,
                                );
                                if (!context.mounted) return;
                                context.pop();
                              },
                              child: Text(
                                "Save",
                                style: getMediumtext(
                                  color: Colors.indigoAccent,
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
          );
        },
        child: Icon(Icons.inventory_2_sharp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                //  padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: adminPvd.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 2 rows vertically
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio:
                      0.35, // Adjusts width-to-height ratio of chips
                ),
                itemBuilder: (context, index) {
                  final category = adminPvd.categories[index];
                  final isSelected = selectCateInd == index;
                  return ChoiceChip(
                    label: Text(category.name, overflow: TextOverflow.ellipsis),
                    selected: isSelected,
                    onSelected: (selected) {
                      adminPvd.updateSelectGridCategory(index, category);
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    backgroundColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color:
                            isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productPvd.productList.length,
                itemBuilder: (context, index) {
                  final data = productPvd.productList[index];
                  return selectCateory?.categoryId == data.categoryId
                      ? Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: getMediumtext(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(selectCateory?.name.toString() ?? ""),
                            ],
                          ),
                        ),
                      )
                      : const SizedBox.shrink();
                },
              ),
            ),

            // TextFieldWidget(
            //   text: "Product Name",
            //   controller: _productName,
            //   width: double.infinity,
            //   onTap: () {},
            //   onTapOutside: (v) {
            //     FocusScope.of(context).unfocus();
            //   },
            //   line: 1,
            // ),

            // CustomPopUp(
            //   text: "Category",
            //   width: double.infinity,
            //   onSelected: (v) {
            //     productPvd.updateProductCategory(v);
            //   },
            //   selectedText: category?.name ?? "",
            //   itemBuilder: (BuildContext context) {
            //     return adminPvd.categories.map<PopupMenuEntry<Category>>((
            //       data,
            //     ) {
            //       return PopupMenuItem(
            //         value: data,
            //         child: Row(children: [Expanded(child: Text(data.name))]),
            //       );
            //     }).toList();
            //   },
            // ),

            // TextFieldWidget(
            //   text: "Stock",
            //   controller: _productStock,
            //   width: double.infinity,
            //   onTap: () {},
            //   onTapOutside: (v) {
            //     FocusScope.of(context).unfocus();
            //   },
            //   line: 1,
            // ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
