import 'dart:io';
import 'package:projeto_livro/livro_concluido.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper2 {
  DatabaseHelper2._privateConstructor();
  static final DatabaseHelper2 instance = DatabaseHelper2._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'concluidos5.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE concluidos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT,
      autor TEXT,
      formato TEXT,
      dataInicio TEXT,
      dataFinal TEXT,
      tempoFinal TEXT,
      dias INTEGER
    )
    ''');
  }

  Future<List<LivroConcluido>> getConcluidos() async {
    Database db = await instance.database;
    var concluidos = await db.query('concluidos', orderBy: 'id DESC');
    List<LivroConcluido> concluidoList = concluidos.isNotEmpty
        ? concluidos.map((c) => LivroConcluido.fromMap(c)).toList()
        : [];
    return concluidoList;
  }

  Future<int> add(LivroConcluido livro) async {
    Database db = await instance.database;
    final id = await db.insert('concluidos', livro.toMap());
    return id;
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('concluidos', where: 'id = ?', whereArgs: [id]);
  }
}
