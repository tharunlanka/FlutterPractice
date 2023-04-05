import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/ListTranscations.dart';

class DatabaseHelper {


  static Database? _database;
  String tableName = "Transaction";
  String amount = "Amount";
  String id = "Id";
  String title = "Title";
  DateTime?  date;

  DatabaseHelper._createInstance();
  static final DatabaseHelper instance = DatabaseHelper._createInstance();


  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}Transaction.db';
    //create db in given path
    return openDatabase(path, version: 1, onCreate: _onCreateDatabase);
  }


  Future _onCreateDatabase(Database db, int dbversion) async {
    return await db.execute('''
         CREATE TABLE $tableName ($id INTEGER PRIMARY KEY,
         $title TEXT NOT NULL,$amount TEXT NOT NULL,$date TEXT NOT NULL)
      ''');
  }

  Future<Database?> get database async {
    _database ??= _initiateDatabase();
    return _database;
  }


  Future<List<ListTranscations>?> getTransactionList() async {
    Database? database= _database;
    List<Map<String, Object?>>? list = await database?.query(tableName);
    return list?.map((data) => ListTranscations.fromMapObj(data)).toList();
  }

  insertList(ListTranscations data) async{
    Database? database= _database;
    return database?.insert(tableName,data.toMap());
  }

  updateList(ListTranscations data) async{
  Database? db = await instance.database;
  return await db!
      .update(tableName,data.toMap(), where: '$id=?', whereArgs: [data.id]);
  }
  deleteList(int listId)async{
    Database? db = await instance.database;
    return await db!
        .rawDelete('DELETE FROM $tableName WHERE $id = $listId');
  }
}
