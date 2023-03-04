import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Termin {
  final int? id;
  final String course_name;
  final String termin_date;
  final int created_by;
  Termin(
      {this.id,
      required this.course_name,
      required this.termin_date,
      required this.created_by});
  factory Termin.fromMap(Map<String, dynamic> json) => new Termin(
      id: json['id'],
      course_name: json['course_name'],
      termin_date: json['termin_date'],
      created_by: json['created_by']);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course_name': course_name,
      'termin_date': termin_date,
      'created_by': created_by,
    };
  }

  @override
  String toString() {
    return 'Termin id:${id} Course Name: ${course_name} Date: ${termin_date}';
  }
}


class TerminHelper {
  static List<Termin> temp = <Termin>[];
}

class TerminDatabaseHelper {
  TerminDatabaseHelper._privateConstructor();
  static final TerminDatabaseHelper instance =
      TerminDatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'termin.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE termin(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          course_name TEXT,
          termin_date TEXT,
          created_by INTEGER
      )
      ''');
  }

  Future<List<Termin>> getTermins() async {
    Database db = await instance.database;
    var dbusers = await db.query('termin', orderBy: 'course_name');
    List<Termin> termins = dbusers.isNotEmpty
        ? dbusers.map((c) => Termin.fromMap(c)).toList()
        : [];
    TerminHelper.temp = termins;
    return termins;
  }

  Future<int> addTermin(Termin new_termin) async {
    Database db = await instance.database;
    return await db.insert('termin', new_termin.toMap());
  }

  Future<int> updateTermin(Termin termin) async {
    Database db = await instance.database;
    return await db.update('termin', termin.toMap(),
        where: "id = ?", whereArgs: [termin.id]);
  }
}
