// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../../../features/settings/presentation/cubit/settings_cubit.dart';
// import '../di/get_it.dart';

// initialSqlDb() async {
//   final dbHelper = getIt<SqlDatabaseHelper>();
//   try {
//     await dbHelper.database; // Initialize the database
//     debugPrint('SQL Log  >> Database initialized successfully');
//   } catch (e) {
//     debugPrint('SQL Log  >> Failed to initialize database: $e');
//   }
// }

// class SqlDatabaseHelper {
//   static Database? _database;

//   // String productsTable = 'Products';
//   // String transferProductsTable = 'TransferProducts';
//   // String receivingProductsTable = 'Receiving';
//   /// Active
//   String normalPiProductsTable = 'NormalPiProducts';
//   String customPiProductsTable = 'CustomPiProducts';

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'item_master.db');
//     debugPrint('SQL Log  >> Database path: $path');
//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     /// Normal Pi Table
//     await db.execute('''
//       CREATE TABLE $normalPiProductsTable(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         upc TEXT,
//         alu TEXT,
//         description1 TEXT,
//         description2 TEXT,
//         scannedQty INTEGER,
//         qty INTEGER,
//         modifiedDateTimeInmillisSinceEpoch INTEGER,
//         isScanned INTEGER
//         )
//     ''');

//     /// Custom Pi Table
//     await db.execute('''
//       CREATE TABLE $customPiProductsTable(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         sku TEXT,
//         description1 TEXT,
//         description2 TEXT,
//         scannedQty INTEGER,
//         attribute INTEGER,
//         size INTEGER,
//         qty INTEGER,
//         uom TEXT,
//         modifiedDateTimeInMillisSinceEpoch INTEGER,
//         isScanned INTEGER
//         )
//     ''');

//     // await db.execute('''
//     //   CREATE TABLE TransferProducts(
//     //     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     //     upc TEXT,
//     //     alu TEXT,
//     //     description1 TEXT,
//     //     description2 TEXT,
//     //     qty INTEGER
//     //     )
//     // ''');
//     // await db.execute('''
//     //   CREATE TABLE Receiving(
//     //     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     //     upc TEXT,
//     //     alu TEXT,
//     //     description1 TEXT,
//     //     description2 TEXT,
//     //     qty INTEGER
//     //     )
//     // ''');
//     // await db.execute('''
//     //   CREATE TABLE PiProducts(
//     //     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     //     upc TEXT,
//     //     alu TEXT,
//     //     description1 TEXT,
//     //     description2 TEXT,
//     //     qty INTEGER
//     //     )
//     // ''');
//   }

//   // Insert a record
//   Future<int> insert(String table, Map<String, dynamic> data) async {
//     Database db = await database;
//     return await db.insert(
//       table,
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Query all records
//   Future<List<Map<String, dynamic>>> queryAll(String table) async {
//     Database db = await database;
//     return await db.query(table);
//   }

//   // Query all records where isScanned = 1
//   Future<List<Map<String, dynamic>>> getAllScanned(String table) async {
//     Database db = await database;
//     return await db.query(table, where: 'isScanned = ?', whereArgs: [1]);
//   }

//   // Query products by page, sorted by modifiedDateTimeInmillisSinceEpoch descending, and filtered by isScanned
//   Future<List<Map<String, dynamic>>> getProductsByPage({
//     required String table,
//     required int page,
//     required int pageSize,
//     required int isScanned,
//   }) async {
//     Database db = await database;
//     int offset = (page - 1) * pageSize;
//     return await db.query(
//       table,
//       where: 'isScanned = ?',
//       whereArgs: [isScanned],
//       orderBy: 'modifiedDateTimeInmillisSinceEpoch DESC',
//       limit: pageSize,
//       offset: offset,
//     );
//   }

//   Future<Map<String, dynamic>?> getProductByKey(
//     String table,
//     String identifierValue,
//   ) async {
//     Database db = await database;
//     List<Map<String, dynamic>> result = await db.query(
//       table,
//       where: '$productIdentifierKey = ?',
//       whereArgs: [identifierValue],
//     );
//     return result.isNotEmpty ? result.first : null;
//   }

//   Future<Map<String, dynamic>?> getProductBySku(
//     String table,
//     String identifierValue,
//   ) async {
//     Database db = await database;
//     List<Map<String, dynamic>> result = await db.query(
//       table,
//       where: 'sku = ?',
//       whereArgs: [identifierValue],
//     );
//     return result.isNotEmpty ? result.first : null;
//   }

//   Future<int> updateQtyByKey({
//     required String table,
//     required double qty,
//     required String identifierValue,
//   }) async {
//     Database db = await database;
//     return await db.update(
//       table,
//       {
//         'scannedQty': qty,
//         'isScanned': 1,
//         'modifiedDateTimeInmillisSinceEpoch':
//             DateTime.now().millisecondsSinceEpoch,
//       },
//       where: '$productIdentifierKey = ?',
//       whereArgs: [identifierValue],
//     );
//   }

//   Future<int> updateQtyBySku({
//     required String table,
//     required double qty,
//     required String identifierValue,
//   }) async {
//     Database db = await database;
//     return await db.update(
//       table,
//       {
//         'scannedQty': qty,
//         'isScanned': 1,
//         'modifiedDateTimeInmillisSinceEpoch':
//             DateTime.now().millisecondsSinceEpoch,
//       },
//       where: 'sku = ?',
//       whereArgs: [identifierValue],
//     );
//   }

//   // // Query a single record by upc
//   // Future<List<Map<String, dynamic>?>> queryByUPC(String table, int id) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'upc = ?',
//   //     whereArgs: [id],
//   //   );
//   //   return result.isNotEmpty ? result : [];
//   // }
//   // // Query a single record by upc
//   // Future<List<Map<String, dynamic>?>> queryByAlu(
//   //     String table,
//   //     String id,
//   //     ) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'alu = ?',
//   //     whereArgs: [id],
//   //   );
//   //   return result.isNotEmpty ? result : [];
//   // }

//   Future<int> getRowCount(String tableName) async {
//     Database db = await database;
//     var result = await db.rawQuery('SELECT COUNT(*) FROM $tableName');
//     int count = Sqflite.firstIntValue(result) ?? 0;

//     return count;
//   }

//   Future<int> getScannedRowCount(String tableName) async {
//     Database db = await database;
//     var result = await db.rawQuery(
//       'SELECT COUNT(*) FROM $tableName WHERE isScanned = 1',
//     );
//     int count = Sqflite.firstIntValue(result) ?? 0;

//     return count;
//   }

//   Future<double> getTotalQtyForScannedItems(String tableName) async {
//     Database db = await database;
//     var result = await db.rawQuery(
//       'SELECT SUM(scannedQty) as totalQty FROM $tableName WHERE isScanned = 1',
//     );
//     double totalQty =
//         result.first['totalQty'] != null
//             ? double.parse(result.first['totalQty'].toString())
//             : 0.0;
//     return totalQty;
//   }

//   // Future<List<Map<String, dynamic>?>> queryByUPCContain(
//   //   String table,
//   //   int id,
//   // ) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'upc LIKE ?',
//   //     whereArgs: ['%$id%'],
//   //   );
//   //   return result.isNotEmpty ? result : [];
//   // }
//   //
//   // Future<List<Map<String, dynamic>?>> queryByAluContain(
//   //   String table,
//   //   String id,
//   // ) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'alu LIKE ?',
//   //     whereArgs: ['%$id%'],
//   //   );
//   //   return result.isNotEmpty ? result : [];
//   // }
//   // Future<List<Map<String, dynamic>?>> queryByDescription1(
//   //   String table,
//   //   String id,
//   // ) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'description1 LIKE ?',
//   //     whereArgs: ['%$id%'],
//   //   );
//   //   return result.isNotEmpty ? result : [];
//   // }
//   //
//   // Future<List<Map<String, dynamic>?>> queryByDescription2(
//   //   String table,
//   //   String id,
//   // ) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'description2 LIKE ?',
//   //     whereArgs: ['%$id%'],
//   //   );
//   //   return result.isNotEmpty ? result : [];
//   // }
//   //
//   // Future<Map<String, dynamic>?> selectByAlu(String table, String id) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'alu = ?',
//   //     whereArgs: [id],
//   //   );
//   //   return result.isNotEmpty ? result.first : null;
//   // }
//   // Future<Map<String, dynamic>?> selectByUpc(String table, String id) async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     table,
//   //     where: 'upc = ?',
//   //     whereArgs: [id],
//   //   );
//   //   return result.isNotEmpty ? result.first : null;
//   // }

//   // Update a record
//   Future<int> update(String table, Map<String, dynamic> data, int id) async {
//     Database db = await database;
//     return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
//   }

//   // Future<int> updateQtyByAlu(String table, int qty, int id) async {
//   //   Database db = await database;
//   //   return await db.update(
//   //     table,
//   //     {'qty': qty},
//   //     where: 'alu = ?',
//   //     whereArgs: [id],
//   //   );
//   // }

//   // Delete a record
//   Future<int> delete(String table, int id) async {
//     Database db = await database;
//     return await db.delete(table, where: 'id = ?', whereArgs: [id]);
//   }

//   // Close the database
//   Future<void> close() async {
//     Database db = await database;
//     await db.close();
//   }

//   // Check if the table has data
//   Future<int> hasData(String table) async {
//     Database db = await database;
//     final result = await db.rawQuery('SELECT COUNT(*) FROM $table');
//     int? count = Sqflite.firstIntValue(result);
//     return count!;
//   }

//   // Delete all records
//   deleteAll(String table) async {
//     Database db = await database;
//     return await db.delete(table);
//   }
// }
