import 'package:control_asistencias/data/db_principal.dart';
import 'package:control_asistencias/data/modelos/alumnos.dart';

class CtrlAlumnos {
  // Operaciones CRUD de los alumnos.
  Future<Alumno> createAlumno(Alumno alumno) async {
    final db = await ControlAsistenciasDB.instance.database;
    final id = await db.insert(tableAlumno, alumno.toJson());
    return alumno.copy(idAlumno: id);
  }

  Future<Alumno> readAlumno(int id) async {
    final db = await ControlAsistenciasDB.instance.database;

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
    final db = await ControlAsistenciasDB.instance.database;
    final result = await db.query(tableAlumno);
    return result.map((json) => Alumno.fromJson(json)).toList();
  }

  Future<int> updateAlumno(Alumno alumno) async {
    final db = await ControlAsistenciasDB.instance.database;
    return db.update(
      tableAlumno,
      alumno.toJson(),
      where: "${AlumnoFields.idAlumno} = ?",
      whereArgs: [alumno.idAlumno],
    );
  }

  Future<int> deleteAlumno(int id) async {
    final db = await ControlAsistenciasDB.instance.database;
    return await db.delete(
      tableAlumno,
      where: "${AlumnoFields.idAlumno} = ?",
      whereArgs: [id],
    );
  }
}
