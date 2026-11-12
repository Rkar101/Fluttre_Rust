import 'package:flutter/material.dart';
import 'package:rust_flutter/features/admin/repository/admin_repo.dart';
import 'package:rust_flutter/features/products/model/product_model.dart';

import '../../features/admin/model/dashboard_model.dart';

class OwnerProvider with ChangeNotifier {
  final AdminRepo _repository;

  OwnerProvider({required AdminRepo repository}) : _repository = repository;

  AdminDashboardStats? adminData;

  List<Category> categories = [];

  Future<void> getAdminDashBoard() async {
    final result = await _repository.getAdminDashBoard();
    result.fold((failure) {}, (success) {
      adminData = success.data;
      notifyListeners();
    });
  }

  Future<void> getAdminCategory() async {
    final result = await _repository.getAdminCategory();
    result.fold((failure) {}, (success) {
      categories = success.data;
      notifyListeners();
    });
  }
}
