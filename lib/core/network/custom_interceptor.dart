import 'package:dio/dio.dart';
import 'package:rust_flutter/core/database/secure_db.dart';

import '../../routes/page_router.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // 1. Clear secure storage
      await SecureStorage.secureDelete();
      final path = err.requestOptions.path;

      // Don't logout when login itself fails.
      if (path != PageRouter.authPage) {
        globalAuthNotifier.value = false;
      }
    }
    super.onError(err, handler);
  }
}
