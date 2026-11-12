import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:rust_flutter/routes/api_routes.dart';

import '../../../core/network/dio_client.dart';
import '../../products/model/product_model.dart';
import '../model/shopdata_model.dart';

final logger = Logger();

class ShopDataAPI {
  final _dio = DioClient();

  Future<ResponseShopListStatus> getShopDataList() async {
    try {
      final response = await _dio.dio.get(fetchShopList);
      return ResponseShopListStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }

  Future<ResponseStatus> createShop(ShopdataModel shopData) async {
    try {
      final response = await _dio.dio.post(fetchShopList, data: shopData);
      return ResponseStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }

  Future<ResponseStatus> editShop(ResponseShopData shopData) async {
    try {
      final response = await _dio.dio.post(editserviceShop, data: shopData);
      return ResponseStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }

  Future<ResponseShopProducts> fetchShopProducts() async {
    try {
      final response = await _dio.dio.get(fetchProductList);
      return ResponseShopProducts.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }

  Future<ResponseShopInventory> fetchShopInventory(int shopId) async {
    try {
      final response = await _dio.dio.post(
        fetchInventorybyShopId,
        data: shopId,
      );
      return ResponseShopInventory.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }

  Future<ResponseStatus> addProductInventory(InventoryData productInv) async {
    try {
      final response = await _dio.dio.post(addInventoryData, data: productInv);
      return ResponseStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }
}
