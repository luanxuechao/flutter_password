final String columnId = 'id';
final String columnName = 'name';
final String columnUsername = 'username';
final String columnPassword = 'password';
final String columnNotes = 'notes';
final String columnFavourite = 'favourite';
final String columnPasswordRepormpt = 'password_repormpt';
final String columnupdatedAt = 'updated_at';

class PasswordModel {
  int id;
  String name;
  String url;
  String username;
  String password;
  String notes;
  int favourite;
  int passwordRepormpt;
  int updatedAt;
  PasswordModel({
      this.name,
      this.url,
      this.username,
      this.password,
      this.notes,
      this.favourite,
      this.passwordRepormpt,
      this.updatedAt,});
  // PasswordModel(String name, String url, String username, String password,
  //     String notes, int favourite, int passwordRepormpt) {
  //   this.name = name;
  //   this.url = url;
  //   this.username = username;
  //   this.password = password;
  //   this.notes = notes;
  //   this.favourite = favourite;
  //   this.passwordRepormpt = passwordRepormpt;
  //   this.updatedAt =  ((new DateTime.now()).millisecondsSinceEpoch/1000).round();
  // }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: this.name,
      columnUsername: this.username,
      columnPassword: this.password,
      columnNotes: this.notes,
      columnFavourite: this.favourite,
      columnPasswordRepormpt: this.passwordRepormpt,
      columnupdatedAt: this.updatedAt
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  PasswordModel.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.name = map[columnName];
    this.password = map[columnPassword];
    this.notes = map[columnNotes];
    this.favourite = map[columnFavourite];
    this.passwordRepormpt = map[columnPasswordRepormpt];
    this.updatedAt = map[columnupdatedAt];
  }
}
