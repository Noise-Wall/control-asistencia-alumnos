/// Modelo para la tabla de asistencias.
/// Contiene una clave foránea a la tabla Alumnos.
///
/// La columna "fecha" es el dia en que se tomó la asistencia.
///
/// La columna "marca" consiste de un entero que representa el status de la
/// asistencia:
///
/// 0: presente
/// 1: retardo
/// 2: justificación
/// 3: falta

const String tableAsistencias = 'Asistencias';

class AsistenciaFields {
  static final List<String> values = [
    idAsistencia, idAlumno, fecha, marca,
  ];

  static const String idAsistencia = '_idAsistencia';
  static const String idAlumno = 'idAlumno';
  static const String fecha = 'fecha';
  static const String marca = 'marca';
}

class Asistencia {
  final int? idAsistencia;
  final int idAlumno;
  final DateTime fecha;
  final int marca;

  const Asistencia({
    this.idAsistencia,
    required this.idAlumno,
    required this.fecha,
    required this.marca,
  });

  Map<String, Object?> toJson() => {
        AsistenciaFields.idAsistencia: idAsistencia,
        AsistenciaFields.idAlumno: idAlumno,
        AsistenciaFields.fecha: fecha,
        AsistenciaFields.marca: marca,
      };

  Asistencia copy({
    int? idAsistencia,
    int? idAlumno,
    DateTime? fecha,
    int? marca,
  }) =>
      Asistencia(
        idAsistencia: idAsistencia ?? this.idAsistencia,
        idAlumno: idAlumno ?? this.idAlumno,
        fecha: fecha ?? this.fecha,
        marca: marca ?? this.marca,
      );

  static Asistencia fromJson(Map<String, Object?> json) => Asistencia(
    idAsistencia: json[AsistenciaFields.idAsistencia] as int?,
    idAlumno: json[AsistenciaFields.idAlumno] as int,
    fecha: DateTime.parse(json[AsistenciaFields.fecha] as String),
    marca: json[AsistenciaFields.marca] as int,
  );
}
