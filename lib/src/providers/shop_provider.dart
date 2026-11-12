import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rust_flutter/features/shopdata/repositories/shopdata_repo.dart';
import '../../core/database/secure_const.dart';
import '../../core/database/secure_db.dart';
import '../enums/emp_role.dart';
import '../../features/products/model/product_model.dart';
import '../../features/shopdata/model/shopdata_model.dart';

class ShopProvider with ChangeNotifier {
  final ShopdataRepo _shopdataRepo;

  List<ResponseShopData> shopList = [];

  List<Product> productList = [];

  List<InventoryViewData> inventorydataUi = [];

  bool isVisible = false;

  int selectedIndex = 0;

  int? _expandedIndex;

  int? get expandedIndex => _expandedIndex;

  List<InventoryViewData> basketProduct = [];

  void updateExpandedIndex(int? index) {
    _expandedIndex = index;
    notifyListeners();
  }

  ShopProvider({required ShopdataRepo shopdataRepo})
    : _shopdataRepo = shopdataRepo;

  Future<void> getShopList() async {
    isVisible = false;
    notifyListeners();
    final result = await _shopdataRepo.getShopDataList();
    result.fold(
      (failure) {
        shopList = [];
      },
      (success) {
        shopList = success.shopList ?? [];
        notifyListeners();
      },
    );
    isVisible = true;
    notifyListeners();
  }

  AuthRole empRole = AuthRole.employee;

  getData() async {
    final empRoleS = await SecureStorage.secureRead(SecureConst.empRole);

    empRole = parseRole(empRoleS);

    _expandedIndex = null;

    notifyListeners();
  }

  Future<void> createShop(
    String shopName,
    String contact,
    String address,
    String contactLink,
  ) async {
    final shopData = ShopdataModel(
      shopName,
      contact,
      address,
      contactLink,
      true,
    );

    final result = await _shopdataRepo.createShop(shopData);
    result.fold((failure) {}, (success) {
      notifyListeners();
    });
    isVisible = true;
    notifyListeners();
  }

  Future<void> editShop(BuildContext context, ResponseShopData shopData) async {
    final result = await _shopdataRepo.editShop(shopData);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.failMessage),
            backgroundColor: Colors.black,
          ),
        );
      },
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success.msg), backgroundColor: Colors.green),
        );
        notifyListeners();
      },
    );
    isVisible = true;
    notifyListeners();
  }

  Future<void> fectchShopProducts(
    BuildContext context,
    ResponseShopData shopData,
  ) async {
    final result = await _shopdataRepo.getShopProductList();
    result.fold(
      (failure) {
        productList = [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.failMessage),
            backgroundColor: Colors.black,
          ),
        );
      },
      (success) {
        productList = success.productList.data;
        notifyListeners();
      },
    );
    isVisible = true;
    notifyListeners();
  }

  Future<void> fectchShopInventory(BuildContext context, int shopId) async {
    inventorydataUi = [];
    isVisible = false;
    notifyListeners();
    final result = await _shopdataRepo.getShopInventoryList(shopId);
    result.fold(
      (failure) {
        productList = [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.failMessage),
            backgroundColor: Colors.black,
          ),
        );
      },
      (success) {
        inventorydataUi = success.dataList ?? [];
        log("${inventorydataUi.length}");
        notifyListeners();
      },
    );
    isVisible = true;
    notifyListeners();
  }

  updateSelectedCategory(value) {
    selectedIndex = value;
    notifyListeners();
  }

  Future<void> addProductInventory(
    BuildContext context,
    int shopId,
    int productId,
    int categoryId,
    int price,
    int quantity,
  ) async {
    final InventoryData productInv = InventoryData(
      1,
      shopId,
      productId,
      price,
      quantity,
      DateTime.now().toUtc(),
    );

    final result = await _shopdataRepo.addProductInventory(productInv);
    result.fold(
      (failure) {
        productList = [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.failMessage),
            backgroundColor: Colors.black,
          ),
        );
      },
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success.msg.toString()),
            backgroundColor: Colors.black,
          ),
        );
      },
    );
  }
}
