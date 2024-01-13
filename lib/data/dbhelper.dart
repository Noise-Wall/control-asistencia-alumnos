import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class ControlAsistenciasDB {
  static final ControlAsistenciasDB instance = ControlAsistenciasDB._init();

  static Database? _database;

  ControlAsistenciasDB._init();

  Future<Database> get database async {
    if (_database != null) return database!;

    _database = await _initDB('control_asistencias.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Seccion CRUD para los grupos.
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
   CREATE TABLE $tableGrupo (
      ${GrupoFields.idGrupo} $idType,
      ${GrupoFields.nombreGrupo} $textType,
      ${GrupoFields.nombreMateria} $textType,
      ${GrupoFields.turno} $textType,
   }
    ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
