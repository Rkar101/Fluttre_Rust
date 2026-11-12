// lib/features/auth/domain/usecases/login_usecase.dart


import 'package:rust_flutter/features/auth/domain/response_model.dart';

import '../repositories/auth_repo.dart';
import 'user_model.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<LoginResponse> loginCase(String email, String password) async {
    return await repository.login(email, password);
  }

  Future<ResponseModel> regCase(String username, String email, String password) async {
    return await repository.register(username, email, password);
  }
}