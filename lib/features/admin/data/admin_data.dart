import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:rust_flutter/core/network/dio_client.dart';
import 'package:rust_flutter/features/products/model/product_model.dart';

import '../../../routes/api_routes.dart';
import '../../auth/domain/user_model.dart';
import '../model/dashboard_model.dart';

final logger = Logger();

class AdminData {
  final _dio = DioClient();

  Future<ResponseAdminStatus> getAdminDashBoard() async {
    try {
      final response = await _dio.dio.get(adminDashBoard);

      return ResponseAdminStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }

  Future<UserProfile> getUserProfile() async {
    try {
      final response = await _dio.dio.get(userProfile);
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    }
  }

  Future<ResponseCategory> getAdminCategory() async {
    try {
      final response = await _dio.dio.get(adminCategory);

      return ResponseCategory.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    } catch (e) {
      logger.e("CATCH ERROR - $e");
      throw Exception;
    }
  }
}
