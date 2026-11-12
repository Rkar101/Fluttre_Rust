import 'package:fpdart/fpdart.dart';

import '../../../core/exception/failure.dart';
import '../../auth/domain/user_model.dart';
import '../../products/model/product_model.dart';
import '../model/dashboard_model.dart';

abstract class AdminRepo {
  Future<Either<Failure, ResponseAdminStatus>> getAdminDashBoard();

  Future<Either<Failure, ResponseCategory>> getAdminCategory();

  Future<Either<Failure, UserProfile>> getUserProfile();
}
