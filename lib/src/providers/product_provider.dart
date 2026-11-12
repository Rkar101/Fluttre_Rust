import 'package:flutter/material.dart';
import 'package:rust_flutter/features/products/repositories/product_repo.dart';

import '../../features/products/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider({required ProductRepository repository})
    : _repository = repository;

  List<Product> productList = [];

  Category? selectedCategory;

  Product? selectedProduct;

  Future<void> getProductList() async {
    final ProductQuery productReq = ProductQuery(
      page: 1,
      limit: 6,
      name: "",
      sort: null,
      order: null,
      minPrice: null,
      maxPrice: null,
    );
    final result = await _repository.getProductList(productReq);
    result.fold(
      (failure) {
        productList = [];
      },
      (success) {
        productList = success.productList.data;
        notifyListeners();
      },
    );
  }

  updateProductCategory(vdata) {
    selectedCategory = vdata;
    notifyListeners();
  }

  updateSelectProduct(vdata) {
    selectedProduct = vdata;
    notifyListeners();
  }

  Future<void> createProduct(
    BuildContext context,
    int syskey,
    String name,
    int categoryId,
  ) async {
    final CreateProduct crtProduct = CreateProduct(
      name: name,
      categoryId: categoryId,
    );
    final result = await _repository.addProduct(crtProduct);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.failMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      },
      (success) {
        success.state == true
            ? {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success.msg),
                  backgroundColor: Colors.green,
                ),
              ),
            }
            : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(success.msg),
                backgroundColor: Colors.black87,
              ),
            );
      },
    );
  }
}
