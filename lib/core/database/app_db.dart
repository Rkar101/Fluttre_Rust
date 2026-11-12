import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'app_db_tables.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      //  onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    //  await db.execute(AppDatabaseTables.dropTable);
    await db.execute(AppDatabaseTables.orderTable);
  }

  // Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion > 1) {
  //     await db.execute(AppDatabaseTables.addColumn);
  //   }
  // }
}
