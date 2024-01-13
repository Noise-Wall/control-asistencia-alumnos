import 'dart:convert';

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
    if (_database != null) return database!;

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

    // creacion de tabla Grupos.
    await db.execute('''
    CREATE TABLE $tableGrupo (
       ${GrupoFields.idGrupo} $idType,
       ${GrupoFields.nombreGrupo} $textType,
       ${GrupoFields.nombreMateria} $textType,
       ${GrupoFields.turno} $textType,
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
       ${HorarioFields.hora} $intType,
       FOREIGN KEY (${HorarioFields.idGrupo}) REFERENCES $tableGrupo (${GrupoFields.idGrupo})
       ON DELETE CASCADE
    ) 
    ''');
  }

  // Operaciones CRUD con los grupos.
  Future<Grupo> createGrupo(Grupo grupo) async {
    final db = await instance.database;
    final id = await db.insert(tableGrupo, grupo.toJson());
    return grupo.copy(idGrupo: id);
  }

  Future<Grupo> readGrupo(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGrupo,
      columns: GrupoFields.values,
      where: "${GrupoFields.idGrupo} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Grupo.fromJson(maps.first);
    } else {
      throw Exception("ID $id de Grupo no se encontró.");
    }
  }

  Future<List<Grupo>> readGrupoAll() async {
    final db = await instance.database;
    final result = await db.query(tableGrupo);
    return result.map((json) => Grupo.fromJson(json)).toList();
  }

  Future<int> updateGrupo(Grupo grupo) async {
    final db = await instance.database;

    return db.update(
      tableGrupo,
      grupo.toJson(),
      where: "${GrupoFields.idGrupo} = ?",
      whereArgs: [grupo.idGrupo],
    );
  }

  Future<int> deleteGrupo(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableGrupo,
      where: "${GrupoFields.idGrupo} = ?",
      whereArgs: [id],
    );
  }

  // Operaciones CRUD de los alumnos.
  Future<Alumno> createAlumno(Alumno alumno) async {
    final db = await instance.database;
    final id = await db.insert(tableAlumno, alumno.toJson());
    return alumno.copy(idAlumno: id);
  }

  Future<Alumno> readAlumno(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableAlumno,
        columns: AlumnoFields.values,
        where: "${AlumnoFields.idAlumno} = ?",
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Alumno.fromJson(maps.first);
    } else {
      throw Exception("ID $id de Alumno no se encontró.");
    }
  }

  // cambiar a alumnos per grupo
  Future<List<Alumno>> readAlumnoAll() async {
    final db = await instance.database;
    final result = await db.query(tableAlumno);
    return result.map((json) => Alumno.fromJson(json)).toList();
  }

  Future<int> updateAlumno(Alumno alumno) async {
    final db = await instance.database;
    return db.update(
      tableAlumno,
      alumno.toJson(),
      where: "${AlumnoFields.idAlumno} = ?",
      whereArgs: [alumno.idAlumno],
    );
  }

  Future<int> deleteAlumno(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableAlumno,
      where: "${AlumnoFields.idAlumno} = ?",
      whereArgs: [id],
    );
  }

  // Operaciones CRUD de las asistencias.
  Future<Asistencia> createAsistencia(Asistencia asistencia) async {
    final db = await instance.database;
    final id = await db.insert(tableAsistencias, asistencia.toJson());
    return asistencia.copy(idAsistencia: id);
  }

  Future<Asistencia> readAsistencia(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAsistencias,
      columns: AsistenciaFields.values,
      where: "${AsistenciaFields.idAsistencia} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Asistencia.fromJson(maps.first);
    } else {
      throw Exception("ID $id de Asistencia no se encontró.");
    }
  }

  // cambiar a asistencias per alumno
  Future<List<Asistencia>> readAsistenciaAll() async {
    final db = await instance.database;
    final result = await db.query(tableAsistencias);
    return result.map((json) => Asistencia.fromJson(json)).toList();
  }

  Future<int> updateAsistencia(Asistencia asistencia) async {
    final db = await instance.database;
    return db.update(
      tableAsistencias,
      asistencia.toJson(),
      where: "${AsistenciaFields.idAsistencia} = ?",
      whereArgs: [asistencia.idAsistencia],
    );
  }

  Future<int> deleteAsistencia(int id) async {
    final db = await instance.database;
    return await db.delete(tableAsistencias,
        where: "${AsistenciaFields.idAsistencia} = ?", whereArgs: [id]);
  }

  // Operaciones CRUD de los horarios.
  Future<Horario> createHorario(Horario horario) async {
    final db = await instance.database;
    final id = await db.insert(tableHorarios, horario.toJson());
    return horario.copy(idGrupo: id);
  }

  Future<Horario> readHorario(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableHorarios,
      columns: HorarioFields.values,
      where: "${HorarioFields.idHorario} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Horario.fromJson(maps.first);
    } else {
      throw Exception("ID $id de Horarios no se encontró.");
    }
  }

  // cambiar a horarios per grupo
  Future<List<Horario>> readHorarioAll() async {
    final db = await instance.database;
    final result = await db.query(tableHorarios);
    return result.map((json) => Horario.fromJson(json)).toList();
  }

  Future<int> updateHorario(Horario horario) async {
    final db = await instance.database;
    return db.update(tableHorarios, horario.toJson(),
        where: "${HorarioFields.idHorario} = ?",
        whereArgs: [horario.idHorario]);
  }

  Future<int> deleteHorario(int id) async {
    final db = await instance.database;
    return db.delete(tableHorarios,
        where: "${HorarioFields.idHorario} = ?", whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
