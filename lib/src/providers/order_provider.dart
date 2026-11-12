import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:rust_flutter/src/helpers/database_repo/database_repo.dart';
import '../../features/products/model/product_model.dart';

class OrderProvider with ChangeNotifier {
  final AppDatabaseRepository _appDatabaseRepository;

  OrderProvider(this._appDatabaseRepository);

  List<OrderItem> _orderBasket = [];

  List<OrderItem> get orderBasket => _orderBasket;

  OrderItem? _odItem;

  OrderItem? get odItem => _odItem;

  bool loading = false;

  int _totalCount = 0;

  double _totalPrice = 0.00;

  int get totalCount => _totalCount;

  double get totalPrice => _totalPrice;

  initialize({
    required int id,
    required int count,
    required int price,
    required String orderNote,
    required String orderName,
  }) {
    log("Order Name  $orderName ");
    _odItem = _orderBasket.firstWhere(
      (data) => data.id == id,
      orElse:
          () => OrderItem(
            id: id,
            count: count,
            price: price,
            orderName: orderName,
            orderNote: orderNote,
          ),
    );
    notifyListeners();
  }

  Future<void> getDbOrderItem() async {
    _totalCount = 0;
    _totalPrice = 0.00;
    _orderBasket = await _appDatabaseRepository.getDataList();

    if (_orderBasket.isNotEmpty) {
      for (var v in _orderBasket) {
        _totalCount = v.count + _totalCount;
        _totalPrice = (v.price + _totalPrice);
      }
    }
    notifyListeners();
  }

  updateOrderItem(int count, int price) {
    if (loading == true) return null;
    loading = true;
    notifyListeners();
    OrderItem data = OrderItem(
      id: _odItem!.id,
      count: count,
      price: price,
      orderName: _odItem?.orderName ?? "",
      orderNote: _odItem?.orderNote ?? "",
    );
    _odItem = data;

    Future.delayed(Duration(seconds: 1)).then((_) {
      loading = false;
      notifyListeners();
    });
  }

  updateOrderBasket() async {
    _totalCount = 0;
    _totalPrice = 0.00;
    _orderBasket.removeWhere((item) {
      return (item.id == _odItem?.id);
    });

    _odItem!.count > 0
        ? {
          _orderBasket.add(odItem!),
          await _appDatabaseRepository.modifyData(_odItem!),
        }
        : {await _appDatabaseRepository.deleteByKey(odItem!.id)};
    for (var v in _orderBasket) {
      _totalCount = v.count + _totalCount;
      _totalPrice = v.price + _totalPrice;
    }

    notifyListeners();
  }

  OrderCard? checkCard(InventoryViewData invProData) {
    bool orderContain = _orderBasket.any((item) {
      return item.id == invProData.id;
    });
    if (orderContain) {
      OrderItem item = _orderBasket.firstWhere(
        (item) {
          return item.id == invProData.id;
        },
        orElse:
            () => OrderItem(
              id: invProData.id ?? 0,
              count: 1,
              price: invProData.price,
              orderName: invProData.productName,
              orderNote: "",
            ),
      );
      return OrderCard(item: item, order: orderContain);
    }
    return null;
  }
}

class OrderCard {
  final OrderItem item;
  final bool order;

  OrderCard({required this.item, required this.order});
}
