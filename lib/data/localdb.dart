// Este archivo está depreciado porque se ha cambiado la base de datos a
// SQLite.

//import 'package:hive_flutter/hive_flutter.dart';

// Crea una base de datos local.
// class AsistenciasDB {
//   List Grupos = [];
//   final _asistencias = Hive.box('Asistencias');
//   String Profesor = "Profesor";
//
//   // Para desarrollo solamente. Crea un grupo de prueba que contiene:
//   // 0: Nombre de grupo. Cadena
//   // 1: Nombre de materia. Cadena
//   // 2: Numero de alumnos. Entero
//   // 3: Dias habiles. Arreglo de booleanos, cada uno representando un dia de la
//   // semana, empezando por lunes.
//   void crearGrupoPrueba() {
//     Grupos = [
//       [
//         "LISI 9-9",
//         "Materia de Prueba",
//         99,
//         [true, true, true, true, true, true, true]
//       ],
//     ];
//   }
//
//   void loadGrupos() {
//     Grupos = _asistencias.get("GRUPOS");
//   }
//
//   void updateGrupos() {
//     _asistencias.put("GRUPOS", Grupos);
//   }
//
//   void getProfesor() {
//     Profesor = _asistencias.get("PROFESOR");
//   }
//
//   void updateProfesor() {
//     _asistencias.put("PROFESOR", Profesor);
//   }
// }
