import 'package:fpdart/fpdart.dart';
import 'package:rust_flutter/core/exception/failure.dart';

import '../../products/model/product_model.dart';
import '../model/shopdata_model.dart';

abstract class ShopdataRepo {
  Future<Either<Failure, ResponseShopListStatus>> getShopDataList();

  Future<Either<Failure, ResponseStatus>> createShop(ShopdataModel shopData);

  Future<Either<Failure, ResponseStatus>> editShop(ResponseShopData shopData);

  Future<Either<Failure, ResponseShopProducts>> getShopProductList();

  Future<Either<Failure, ResponseShopInventory>> getShopInventoryList(
    int shopId,
  );

  Future<Either<Failure, ResponseStatus>> addProductInventory(
    InventoryData productData,
  );
}
