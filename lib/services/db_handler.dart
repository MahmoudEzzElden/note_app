import 'package:note_app/model/constants.dart';
import 'package:note_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DataBaseHandler {
  static final DataBaseHandler instance = DataBaseHandler._init();

  DataBaseHandler._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDB();
    return _database!;
  }

  Future<Database> _openDB()   async {
    String path = join(await getDatabasesPath(), 'noteDatabase.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE $noteTable(
     $noteID $idType,
     $noteTitle $textType,
     $noteBody $textType,
     $createdTime $textType
     )
      ''');
  }

  ///CRUD
  //Create
  Future<void> createNote(NoteModel noteModel) async {
    final db = await instance.database;
    await db.insert(noteTable, noteModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Note Created');
    print('this is the title ${noteModel.title}');
  }

  //Update
  Future<void> updateNote(NoteModel noteModel) async {
    final db = await instance.database;
    await db.update(noteTable, noteModel.toMap(),
        where: '$noteID= ?',
        whereArgs:[noteModel.id]);
  }
  //Delete
  Future<void> deleteNote(int id) async {
    final db = await instance.database;
    await db.delete(noteTable,
        where: '$noteID= ?',
        whereArgs:[id]);
  }
//ReadAllUsers
  Future<List<NoteModel>> getAllNotes() async{
    final db=await instance.database;
    List<Map<String,dynamic>> maps = await db.query(noteTable);
    return maps.isNotEmpty ?
    maps.map((note) => NoteModel.fromMap(note)).toList(): [];


  }
  //Read One user
  Future<NoteModel> getNote(int id) async{
    final db=await instance.database;
    List<Map<String,dynamic>> maps = await db.query(noteTable);
    return maps.isNotEmpty ? NoteModel.fromMap(maps.first) :
    throw Exception('No user with ID: $id');

  }


  // Future<void> deleteTable() async{
  //   final db =await instance.database;
  //   await db.execute("DROP TABLE IF EXISTS $noteTable");
  //
  //   await db.execute('''
  //    CREATE TABLE $noteTable(
  //    $noteID $idType,
  //    $noteTitle $textType,
  //    $noteBody $textType
  //    )
  //     ''');
  // }
  Future<void> deleteAllData() async{
    final db = await instance.database;
    await db.execute("DELETE FROM $noteTable");
  }

}
