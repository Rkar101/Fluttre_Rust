import 'package:fpdart/fpdart.dart';
import 'package:rust_flutter/core/exception/failure.dart';

import '../model/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, ResponseStatus>> addProduct(CreateProduct crtProduct);

  Future<Either<Failure, ResponseProductListStatus>> getProductList(
    ProductQuery productReq,
  );

  Future<void> editProduct();

  Future<void> deleteProduct();
}
