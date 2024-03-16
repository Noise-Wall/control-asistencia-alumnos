import 'package:control_asistencias/data/db_principal.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:sqflite/utils/utils.dart';

class CtrlHorarios {
  // Operaciones CRUD de los horarios.
  Future<Horario> createHorario(Horario horario) async {
    final db = await ControlAsistenciasDB.instance.database;
    final id = await db.insert(tableHorarios, horario.toJson());
    return horario.copy(idGrupo: id);
  }

  Future<Horario> readHorario(int id) async {
    final db = await ControlAsistenciasDB.instance.database;
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

  Future<List<Horario>> readHorarioFromGrupo(int idGrupo) async {
    final db = await ControlAsistenciasDB.instance.database;
    final result = await db.query(
      tableHorarios,
      where: "${HorarioFields.idGrupo} = ?",
      whereArgs: [idGrupo],
    );
    return result.map((json) => Horario.fromJson(json)).toList();
  }

  Future<List<Map>> readHorarioFromDia(int dia) async {
    final db = await ControlAsistenciasDB.instance.database;
    // final result = await db.query(
    //   tableHorarios,
    //   where: "${HorarioFields.dia} = ?",
    //   whereArgs: [dia],
    // );

    final String query = """
        SELECT $tableHorarios.${HorarioFields.hora}, $tableGrupo.* 
        FROM $tableHorarios 
        RIGHT JOIN $tableGrupo ON $tableGrupo.${GrupoFields.idGrupo} = $tableHorarios.${HorarioFields.idGrupo} 
        WHERE $tableHorarios.${HorarioFields.dia} = $dia
        """;

    final result = await db.rawQuery(query);
    return result.toList();
  }

  Future<int> countHorarioFromGrupo(int idGrupo) async {
    final db = await ControlAsistenciasDB.instance.database;
    final int count = firstIntValue(await db.rawQuery(
            "SELECT COUNT (*) FROM $tableHorarios WHERE ${HorarioFields.idGrupo} = $idGrupo")) ??
        0;
    return count;
  }

  Future<int> countHorarioAll() async {
    final db = await ControlAsistenciasDB.instance.database;
    final int count = firstIntValue(
            await db.rawQuery("SELECT COUNT (*) FROM $tableHorarios")) ??
        0;
    return count;
  }

  Future<int> updateHorario(Horario horario) async {
    final db = await ControlAsistenciasDB.instance.database;
    return db.update(tableHorarios, horario.toJson(),
        where: "${HorarioFields.idHorario} = ?",
        whereArgs: [horario.idHorario]);
  }

  Future<int> deleteHorario(int id) async {
    final db = await ControlAsistenciasDB.instance.database;
    return db.delete(tableHorarios,
        where: "${HorarioFields.idHorario} = ?", whereArgs: [id]);
  }

  Future<int> deleteHorarioFromGrupo(int idGrupo) async {
    print('Id is $idGrupo');
    final db = await ControlAsistenciasDB.instance.database;
    return db.delete(
      tableHorarios,
      where: "${HorarioFields.idGrupo} = ?",
      whereArgs: [idGrupo],
    );
  }
}
