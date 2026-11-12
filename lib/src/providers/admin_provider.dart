import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rust_flutter/features/admin/repository/admin_repo.dart';
import 'package:rust_flutter/features/auth/domain/user_model.dart';
import 'package:rust_flutter/features/products/model/product_model.dart';

import '../../core/database/secure_const.dart';
import '../../core/database/secure_db.dart';
import '../enums/emp_role.dart';
import '../../features/admin/model/dashboard_model.dart';

class AdminProvider with ChangeNotifier {
  final AdminRepo _repository;

  AdminProvider({required AdminRepo repository}) : _repository = repository;

  AdminDashboardStats? adminData;

  int indexTab = 0;

  updateInDexTab(int value) {
    indexTab = value;
    notifyListeners();
  }

  List<Category> categories = [];

  UserProfile? profile;

  Category? selectEd;

  AuthRole empRole = AuthRole.employee;

  getData() async {
    final empRoleS = await SecureStorage.secureRead(SecureConst.empRole);

    empRole = parseRole(empRoleS);

    log(" $empRole");

    notifyListeners();
  }

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

  Future<void> getUserProfile() async {
    final result = await _repository.getUserProfile();
    result.fold((failure) {}, (success) {
      profile = success;
      notifyListeners();
    });
  }

  void selectCategory(Category data) {
    selectEd = data;
    notifyListeners();
  }

  int selectedIndex = 1;

  Category? selectedCategory;

  void updateSelectGridCategory(int index, Category data) {
    selectedCategory = data;
    selectedIndex = index;
    notifyListeners();
  }
}
