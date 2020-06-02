import 'package:flutter_password/db/db_provider.dart';
import 'package:flutter_password/models/password.dart';
import 'package:sqflite/sqlite_api.dart';

class PasswordDao extends BaseDBProvider {
  final String name = 'fp_password';
  final String columnId = 'id';
  @override
  tableName() {
    // TODO: implement tableName
    return name;
  }

  @override
  tablesqlString() {
    // TODO: implement tablesqlString
    return tableBaseString(name, columnId) +
        '''
      name TEXT not null,
      url TEXT,
      username TEXT not null,
      password TEXT,
      notes TEXT,
      favourite INTEGER default 0,
      password_repormpt INTEGER default 0,
      updated_at INTEGER)
    ''';
  }

  Future insert(PasswordModel pwd) async {
    Database db = await getDataBase();
    int i = await db.insert(name, pwd.toMap());
    return i;
  }

  Future deleteById(int id) async {
    Database db = await getDataBase();
    int i = await db.delete(name, where: "id=?", whereArgs: [id]);
    return i;
  }

  Future<List<PasswordModel>> findAll() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.query(name);
    if (maps.length > 0) {
      List<PasswordModel> pwdList =
          maps.map((item) => PasswordModel.fromMap(item)).toList();
      return pwdList;
    }
    return null;
  }

  Future updateById(int id, PasswordModel pwd) async {
    Database db = await getDataBase();
    int i = await db.rawUpdate(
        '''UPDATE fp_password SET favourite =${pwd.favourite} WHERE id=$id''');
    return i;
  }
}
