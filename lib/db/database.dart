import 'dart:io';

import 'package:flutter_task/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  String productsTable = 'Products';
  String columnId = 'id';
  String columnProduct = 'product';
  String columnP1 = 'p1';
  String columnP2 = 'p2';

  Future<Database> get database async {
    // if (_database != null) return _database;

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Product.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Product
  // Id | Product | p1 | p2
  // 0    ..
  // 1    ..

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $productsTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnProduct TEXT, $columnP1 INTEGER, $columnP2 INTEGER)',
    );
  }

  // // READ
  // Future<List<Product>> getProducts() async {
  //   Database db = await this.database;
  //   final List<Map<String, dynamic>> productsMapList =
  //       await db.query(productsTable);
  //   final List<Product> productsList = [];
  //   productsMapList.forEach((productMap) {
  //     productsList.add(Product.fromMap(productMap));
  //   });
  //
  //   return productsList;
  // }

  // INSERT
  Future<void> insertProduct(Product product) async {
    Database db = await this.database;

    await db.insert(productsTable, product.toMap());
    return;
  }

  Future<List<Product>> findProducts(int n) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> productsMapList =
        await db.query(productsTable, where: "p$n = 1");

    final List<Product> productsList = [];
    productsMapList.forEach((productMap) {
      productsList.add(Product.fromMap(productMap));
    });

    return productsList;
  }

  // UPDATE
  // Future<int> updateProduct(Product product) async {
  //   Database db = await this.database;
  //   return await db.update(
  //     productsTable,
  //     product.toMap(),
  //     where: '$columnId = ?',
  //     whereArgs: [product.id],
  //   );
  // }

  // DELETE
  Future<int> deleteProducts() async {
    Database db = await this.database;
    return await db.delete(
      productsTable,
    );
  }
}
