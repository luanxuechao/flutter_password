
import 'package:flutter_password/db/db_provider.dart';
import 'package:flutter_password/models/password.dart';

class PasswordDao extends BaseDBProvider{
  final String name = 'fp_password';
  final String columnId= 'id';
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
      fvourite INTEGER default 0,
      password_repormpt INTEGER default 0; 
      updated_at DATETIME
    ''';
  }
  // Future insert()
}
