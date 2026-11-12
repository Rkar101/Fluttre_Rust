import 'package:fpdart/fpdart.dart';
import 'package:rust_flutter/core/exception/failure.dart';
import 'package:rust_flutter/features/products/model/product_model.dart';
import 'package:rust_flutter/features/shopdata/data/shop_data.dart';
import 'package:rust_flutter/features/shopdata/model/shopdata_model.dart';
import 'package:rust_flutter/features/shopdata/repositories/shopdata_repo.dart';

class ShopdataImpl implements ShopdataRepo {
  final _shopDataApi = ShopDataAPI();

  @override
  Future<Either<Failure, ResponseShopListStatus>> getShopDataList() async {
    try {
      final result = await _shopDataApi.getShopDataList();

      return Either.right(result);
    } catch (e, st) {
      logger.e("shop Data $e ,,, $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<Either<Failure, ResponseStatus>> createShop(
    ShopdataModel shopData,
  ) async {
    try {
      final result = await _shopDataApi.createShop(shopData);

      return Either.right(result);
    } catch (e, st) {
      logger.e("shop Data $e ,,, $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<Either<Failure, ResponseShopProducts>> getShopProductList() async {
    try {
      final result = await _shopDataApi.fetchShopProducts();
      return Either.right(result);
    } catch (e, st) {
      logger.e("shop Data $e ,,, $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<Either<Failure, ResponseShopInventory>> getShopInventoryList(
    int shopId,
  ) async {
    try {
      final result = await _shopDataApi.fetchShopInventory(shopId);
      return Either.right(result);
    } catch (e, st) {
      logger.e("shop Data $e ,,, $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<Either<Failure, ResponseStatus>> addProductInventory(
    InventoryData productData,
  ) async {
    try {
      final result = await _shopDataApi.addProductInventory(productData);
      return Either.right(result);
    } catch (e, st) {
      logger.e("shop Data $e ,,, $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<Either<Failure, ResponseStatus>> editShop(
    ResponseShopData shopData,
  ) async {
    try {
      final result = await _shopDataApi.editShop(shopData);

      return Either.right(result);
    } catch (e, st) {
      logger.e("shop Data $e ,,, $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }
}
