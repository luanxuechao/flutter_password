import 'dart:io';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static const int _VERSION = 1;
  static const String _DB_NAME = 'flutter_password.db';
  static Database _database;
  static init() async {
    var databsaePath = await getDatabasesPath();
    String dbName = _DB_NAME;
    String path = databsaePath + dbName;
    if (Platform.isIOS) {
      path = databsaePath + '/' + dbName;
    }
    _database = await openDatabase(path, version: _VERSION,
        onCreate: (Database db, int version) async {
      // await db.execute(
      //   'CREATE TABLE fp_password (id INTEGER PRIMARY KEY,)');
    });
  }

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    String sql =
        "select * from Sqlite_master where type ='table' and name='$tableName'";
    // String sql = 'DROP TABLE $tableName;';
    var res = await _database.rawQuery(sql);
    print(res);
    return res != null && res.length > 0;
  }
  static close(){
    _database?.close();
    _database =null;
  }
}
