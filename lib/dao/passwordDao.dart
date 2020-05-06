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
    print(pwd.toMap());
    int i  = await db.insert(name, pwd.toMap());
     print(111111);
    print(i);
    return i;
  }
}
