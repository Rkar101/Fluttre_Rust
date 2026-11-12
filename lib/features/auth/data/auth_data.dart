import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../routes/api_routes.dart';
import '../../../core/network/dio_client.dart';
import '../domain/response_model.dart';
import '../domain/user_model.dart';

final logger = Logger();

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String email, String password);

  Future<ResponseModel> register(
    String userName,
    String email,
    String password,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await dioClient.dio.post(
        authLogin,
        data: {'email': email, 'password': password},
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    }
  }

  @override
  Future<ResponseModel> register(
    String userName,
    String email,
    String password,
  ) async {
    final body = {"username": userName, 'email': email, 'password': password};
    logger.i("$body");
    try {
      final response = await dioClient.dio.post(authRegister, data: body);
      return ResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? 'Authentication failed');
    }
  }
}
