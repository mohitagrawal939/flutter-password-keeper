import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'PasswordModel.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String pwdTable = 'user_table';
  String colId = 'id';
  String colTitle = 'title';
  String colUsername = 'username';
  String colPassword = 'password';
  String colDate = 'date';
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'users.db';
    var pwdDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return pwdDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $pwdTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, ''$colUsername TEXT, $colPassword TEXT, $colDate TEXT)');
  }
  Future<List<Map<String, dynamic>>> getPwdMapList() async {
    Database db = await this.database;
    var result = await db.query(pwdTable, orderBy: '$colDate DESC');
    return result;
  }
  Future<int> insertPwd(Pwd pwd) async {
    Database db = await this.database;
    var result = await db.insert(pwdTable, pwd.toMap());
    return result;
  }
  Future<int> updatePwd(Pwd pwd) async {
    var db = await this.database;
    var result = await db.update(pwdTable, pwd.toMap(), where: '$colId = ?', whereArgs: [pwd.id]);
    return result;
  }
  Future<int> deletePwd(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $pwdTable WHERE $colId = $id');
    return result;
  }
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $pwdTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<List<Pwd>> getPwdList() async {
    var pwdMapList = await getPwdMapList();
    int count = pwdMapList.length;
    List<Pwd> pwdList = List<Pwd>();
    for (int i = 0; i < count; i++) {
      pwdList.add(Pwd.fromMapObject(pwdMapList[i]));
    }
    return pwdList;
  }
}