import 'package:flutter/material.dart';
import 'package:flutter_password/db/db_manager.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class BaseDBProvider {
  bool isTableExists = false;
  tablesqlString();
  tableName();

  tableBaseString(String name, String columnId) {
    return '''
    create table $name(
      $columnId integer primary key autoincrement,
      ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(String name, String createSql) async {
    isTableExists = await DBManager.isTableExits(name);
    if (!isTableExists) {
      Database db = await DBManager.getCurrentDatabase();
      return db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExists) {
      await prepare(tableName(), tablesqlString());
    }
    return await DBManager.getCurrentDatabase();
  }
}
