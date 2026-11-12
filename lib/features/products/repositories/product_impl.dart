import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:rust_flutter/core/exception/failure.dart';
import 'package:rust_flutter/features/products/repositories/product_repo.dart';

import '../data/product_data.dart';
import '../model/product_model.dart';

class ProductRepoImpl implements ProductRepository {
  final _productData = ProductData();

  @override
  Future<Either<Failure, ResponseStatus>> addProduct(
    CreateProduct crtProduct,
  ) async {
    try {
      final result = await _productData.addProduct(crtProduct);
      return Either.right(result);
    } catch (e, st) {
      log(" $e ::   $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<void> deleteProduct() {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<void> editProduct() {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseProductListStatus>> getProductList(
    ProductQuery productReq,
  ) async {
    try {
      final result = await _productData.getProductList(productReq);

      return Either.right(result);
    } catch (e, st) {
      log("CATCH ERROR :::  $e ==> $st");
      return Either.left(NetworkFailure("$e", 512));
    }
  }
}
