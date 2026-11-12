

import 'package:rust_flutter/features/auth/domain/response_model.dart';

import '../data/auth_data.dart';
import '../domain/user_model.dart';
import 'auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoginResponse> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return userModel; // Upcasts to Entity
  }

  @override
  Future<ResponseModel> register(String userName, String email, String password) async{
        final repModel = await remoteDataSource.register(userName, email, password);
        return repModel;

  }
}