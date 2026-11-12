import 'package:fpdart/fpdart.dart';
import 'package:rust_flutter/core/exception/failure.dart';
import 'package:rust_flutter/features/admin/model/dashboard_model.dart';
import 'package:rust_flutter/features/admin/repository/admin_repo.dart';
import 'package:rust_flutter/features/auth/domain/user_model.dart';
import 'package:rust_flutter/features/products/model/product_model.dart';

import '../data/admin_data.dart';

class AdminRepositoryImpl implements AdminRepo {
  final _adminData = AdminData();

  @override
  Future<Either<Failure, ResponseAdminStatus>> getAdminDashBoard() async {
    try {
      final result = await _adminData.getAdminDashBoard();
      return Either.right(result);
    } catch (e) {
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<Either<Failure, ResponseCategory>> getAdminCategory() async {
    try {
      final result = await _adminData.getAdminCategory();
      return Either.right(result);
    } catch (e) {
      return Either.left(NetworkFailure("$e", 512));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final result = await _adminData.getUserProfile();
      return Either.right(result);
    } catch (e) {
      return Either.left(NetworkFailure("$e", 512));
    }
  }
}
