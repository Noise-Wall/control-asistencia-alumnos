import 'package:control_asistencias/data/db_principal.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:sqflite/utils/utils.dart';

class CtrlGrupos {
  // Operaciones CRUD con los grupos.
  Future<Grupo> createGrupo(Grupo grupo) async {
    final db = await ControlAsistenciasDB.instance.database;
    final id = await db.insert(tableGrupo, grupo.toJson());
    return grupo.copy(idGrupo: id);
  }

  Future<Grupo> readGrupo(int id) async {
    final db = await ControlAsistenciasDB.instance.database;

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
    final db = await ControlAsistenciasDB.instance.database;
    final result = await db.query(tableGrupo);
    return result.map((json) => Grupo.fromJson(json)).toList();
  }

  Future<int> updateGrupo(Grupo grupo) async {
    final db = await ControlAsistenciasDB.instance.database;

    return db.update(
      tableGrupo,
      grupo.toJson(),
      where: "${GrupoFields.idGrupo} = ?",
      whereArgs: [grupo.idGrupo],
    );
  }

  Future<int> deleteGrupo(int id) async {
    final db = await ControlAsistenciasDB.instance.database;
    return await db.delete(
      tableGrupo,
      where: "${GrupoFields.idGrupo} = ?",
      whereArgs: [id],
    );
  }

  Future<int> countGrupo() async {
    final db = await ControlAsistenciasDB.instance.database;
    final int count =
        firstIntValue(await db.rawQuery("SELECT COUNT (*) FROM $tableGrupo")) ??
            0;
    return count;
  }
}
