import 'package:rust_flutter/features/auth/domain/response_model.dart';

import '../domain/user_model.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(String email, String password);

  Future<ResponseModel> register(String userName,String email, String password);
}