import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notice_flutter_app/model/todo.dart';

class TodoDatabase {
  TodoDatabase._init();
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;

  //get connection
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create a DB
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableTodo (
      ${TodoFields.id} $idType,
      ${TodoFields.number} $integerType,
      ${TodoFields.title} $textType,
      ${TodoFields.description} $textType
      )
      ''');
  }

  //insert in the database
  Future<Todo> create(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableTodo, todo.toJson());
    return todo.copy(id: id);
  }

  //read a note
  Future<Todo> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTodo,
      columns: TodoFields.values,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //read all Notes from the database in a list
  Future<List<Todo>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${TodoFields.id} ASC';

    final result = await db.query(tableTodo, orderBy: orderBy);
    return result.map((json) => Todo.fromJson(json)).toList();
  }

  //changed sth in database
  Future<int> update(Todo todo) async {
    final db = await instance.database;

    return db.update(
      tableTodo,
      todo.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  //delete from database
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableTodo, where: '${TodoFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
