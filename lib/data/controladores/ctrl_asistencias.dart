import 'package:control_asistencias/data/db_principal.dart';
import 'package:control_asistencias/data/modelos/asistencias.dart';

class CtrlAsistencias {
  // Operaciones CRUD de las asistencias.
  Future<Asistencia> createAsistencia(Asistencia asistencia) async {
    final db = await ControlAsistenciasDB.instance.database;
    final id = await db.insert(tableAsistencias, asistencia.toJson());
    return asistencia.copy(idAsistencia: id);
  }

  Future<Asistencia> readAsistencia(int id) async {
    final db = await ControlAsistenciasDB.instance.database;

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
    final db = await ControlAsistenciasDB.instance.database;
    final result = await db.query(tableAsistencias);
    return result.map((json) => Asistencia.fromJson(json)).toList();
  }

  Future<int> updateAsistencia(Asistencia asistencia) async {
    final db = await ControlAsistenciasDB.instance.database;
    return db.update(
      tableAsistencias,
      asistencia.toJson(),
      where: "${AsistenciaFields.idAsistencia} = ?",
      whereArgs: [asistencia.idAsistencia],
    );
  }

  Future<int> deleteAsistencia(int id) async {
    final db = await ControlAsistenciasDB.instance.database;
    return await db.delete(tableAsistencias,
        where: "${AsistenciaFields.idAsistencia} = ?", whereArgs: [id]);
  }
}
