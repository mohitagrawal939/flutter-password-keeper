class Pwd {

  int _id;
  String _title;
  String _username;
  String _password;
  String _date;

  Pwd(this._title, this._date, this._username, this._password );

  Pwd.withId(this._id, this._title, this._date, this._username, this._password );

  int get id => _id;

  String get title => _title;

  String get username => _username;

  String get password => _password;

  String get date => _date;


  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }
  set username(String newUsername) {
    if (newUsername.length <= 255) {
      this._username = newUsername;
    }
  }
  set password(String newPassword) {
    if (newPassword.length <= 255) {
      this._password = newPassword;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['username'] = _username;
    map['password'] = _password;
    map['date'] = _date;
    return map;
  }

  Pwd.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._username = map['username'];
    this._password = map['password'];
    this._date = map['date'];
  }
}