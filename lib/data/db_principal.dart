import 'package:control_asistencias/data/modelos/alumnos.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:control_asistencias/data/modelos/asistencias.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';

import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class ControlAsistenciasDB {
  static final ControlAsistenciasDB instance = ControlAsistenciasDB._init();

  static Database? _database;

  ControlAsistenciasDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('control_asistencias.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const doubleType = 'DOUBLE(2, 2) NOT NULL';

    // creacion de tabla Grupos.
    await db.execute('''
    CREATE TABLE $tableGrupo (
       ${GrupoFields.idGrupo} $idType,
       ${GrupoFields.nombreGrupo} $textType,
       ${GrupoFields.nombreMateria} $textType,
       ${GrupoFields.turno} $textType
    )
    ''');

    // creacion de tabla Alumnos.
    await db.execute('''
    CREATE TABLE $tableAlumno (
      ${AlumnoFields.idAlumno} $idType,
      ${AlumnoFields.idGrupo} $intType,
      ${AlumnoFields.apellidosAlumno} $textType,
      ${AlumnoFields.nombreAlumno} $textType,
      FOREIGN KEY (${AlumnoFields.idGrupo}) REFERENCES $tableGrupo (${GrupoFields.idGrupo})
      ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableAsistencias (
      ${AsistenciaFields.idAsistencia} $idType,
      ${AsistenciaFields.idAlumno} $intType,
      ${AsistenciaFields.fecha} $textType,
      ${AsistenciaFields.marca} $intType,
      FOREIGN KEY (${AsistenciaFields.idAlumno}) REFERENCES $tableAlumno (${AlumnoFields.idAlumno})
      ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableHorarios (
       ${HorarioFields.idHorario} $idType,
       ${HorarioFields.idGrupo} $intType,
       ${HorarioFields.dia} $intType,
       ${HorarioFields.hora} $doubleType,
       FOREIGN KEY (${HorarioFields.idGrupo}) REFERENCES $tableGrupo (${GrupoFields.idGrupo})
       ON DELETE CASCADE
    ) 
    ''');
  }



  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
