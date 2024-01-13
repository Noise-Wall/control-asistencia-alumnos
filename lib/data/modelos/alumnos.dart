const String tableAlumno = 'Alumnos';

class AlumnoFields {
  static final List<String> values = [
    idAlumno, idGrupo, nombreAlumno, apellidosAlumno,
  ];

  static const String idAlumno = '_idAlumno';
  static const String idGrupo = 'idGrupo';
  static const String nombreAlumno = 'nombreAlumno';
  static const String apellidosAlumno = 'apellidosAlumno';
}

class Alumno {
  final int? idAlumno;
  final int idGrupo;
  final String nombreAlumno;
  final String apellidosAlumno;

  const Alumno({
    this.idAlumno,
    required this.idGrupo,
    required this.nombreAlumno,
    required this.apellidosAlumno,
  });

  Map<String, Object?> toJson() => {
        AlumnoFields.idAlumno: idAlumno,
        AlumnoFields.idGrupo: idGrupo,
        AlumnoFields.nombreAlumno: nombreAlumno,
        AlumnoFields.apellidosAlumno: apellidosAlumno,
      };

  Alumno copy({
    int? idAlumno,
    int? idGrupo,
    String? nombreAlumno,
    String? apellidosAlumno,
  }) =>
      Alumno(
        idAlumno: idAlumno ?? this.idAlumno,
        idGrupo: idGrupo ?? this.idGrupo,
        nombreAlumno: nombreAlumno ?? this.nombreAlumno,
        apellidosAlumno: apellidosAlumno ?? this.apellidosAlumno,
      );

  static Alumno fromJson(Map<String, Object?> json) => Alumno(
    idAlumno: json[AlumnoFields.idAlumno] as int?,
    idGrupo: json[AlumnoFields.idGrupo] as int,
    nombreAlumno: json[AlumnoFields.nombreAlumno] as String,
    apellidosAlumno: json[AlumnoFields.apellidosAlumno] as String,
  );
}
