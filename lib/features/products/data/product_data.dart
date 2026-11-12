
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:rust_flutter/core/network/dio_client.dart';

import '../../../routes/api_routes.dart';
import '../model/product_model.dart';

final logger = Logger();


class ProductData {

  final _dio = DioClient();

  Future<ResponseStatus> addProduct(CreateProduct crtProduct) async {
    try {
      final response = await _dio.dio.post(
        getProduct,
        data: crtProduct.toJson(),
      );
      return ResponseStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch(e){
      log("add Product Error $e");
      throw Exception;
    }
  }

  Future<ResponseProductListStatus> getProductList(ProductQuery productReq) async {
    try {
      final response = await _dio.dio.get(
        fetchProductList,
        data: productReq.toJson(),
      );

      return ResponseProductListStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch(e){
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }

    Future<ResponseProductListStatus> getShopProductList(ProductQuery productReq) async {
    try {
      final response = await _dio.dio.get(
        fetchProductList,
        data: productReq.toJson(),
      );

      return ResponseProductListStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch(e){
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }
}
