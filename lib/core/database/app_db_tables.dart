class AppDatabaseTables {
  static const ordertabelTitle = "orders";

  static const orderTable = '''
      CREATE TABLE IF NOT EXISTS $ordertabelTitle (
        id INTEGER PRIMARY KEY,
        count INTEGER NOT NULL,
        price INTEGER NOT NULL,
        orderName TEXT NOT NULL,
        orderNote TEXT NOT NULL
      )
    ''';

  static const dropTable = 'DROP TABLE IF EXISTS orders;';

  // static const addColumn = '''
  //       ALTER TABLE $ordertabelTitle ADD COLUMN orderName TEXT NOT NULL DEFAULT ''
  //     ''';
}
