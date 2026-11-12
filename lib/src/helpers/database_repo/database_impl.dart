import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:rust_flutter/src/helpers/database_repo/database_repo.dart';
import '../../../core/database/app_db.dart';
import '../../../core/database/app_db_tables.dart';
import '../../../features/products/model/product_model.dart';

class AppDatabaseImpl implements AppDatabaseRepository {
  final AppDatabase appDatabase;

  AppDatabaseImpl(this.appDatabase);

  @override
  Future<List<OrderItem>> getDataList() async {
    final db = await appDatabase.database;
    final listData = await db.query(AppDatabaseTables.ordertabelTitle);
    return listData.map((e) => OrderItem.fromJson(e)).toList();
  }

  @override
  Future<void> modifyData(OrderItem data) async {
    final db = await appDatabase.database;
    await db.insert(
      AppDatabaseTables.ordertabelTitle,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteByKey(int id) async {
    final db = await appDatabase.database;
    await db.delete(
      AppDatabaseTables.ordertabelTitle,
      where: 'id = ?',
      whereArgs: [id],
    );
    log(" THis is Delete");
  }

  @override
  Future<void> deleteData() async {
    final db = await appDatabase.database;
    await db.delete(AppDatabaseTables.ordertabelTitle);
  }
}
