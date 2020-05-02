final String columnId = 'id';
final String columnName = 'name';
final String columnUsername = 'username';
final String columnPassword = 'password';
final String columnNotes = 'notes';
final String columnFavourite = 'favourite';
final String columnPasswordRepormpt = 'password_repormpt';
final String columnupdatedAt = 'update_at';

class PasswordModel {
   String id;
   String name;
   String url;
   String username;
  String password;
   String notes;
   int favourite;
  int passwordRepormpt;
   DateTime updatedAt;

  PasswordModel(
      {this.id,
      this.name,
      this.url,
      this.username,
      this.password,
      this.notes,
      this.favourite,
      this.passwordRepormpt,
      this.updatedAt});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnUsername: username,
      columnPassword: password,
      columnNotes: notes,
      columnFavourite: favourite,
      columnPasswordRepormpt: passwordRepormpt,
      columnupdatedAt: updatedAt
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  PasswordModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    password = map[columnPassword];
    notes = map[columnNotes];
    favourite = map[columnFavourite];
    passwordRepormpt = map[columnPasswordRepormpt];
    updatedAt = map[columnupdatedAt];
  }
}
