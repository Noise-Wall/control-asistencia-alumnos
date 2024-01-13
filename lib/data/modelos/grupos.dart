const String tableGrupo = 'Grupos';

class GrupoFields {
  static final List<String> values = [
    idGrupo, nombreGrupo, nombreMateria, turno
  ];

  static const String idGrupo = '_idGrupo';
  static const String nombreGrupo = 'nombreGrupo';
  static const String nombreMateria = 'nombreMateria';
  static const String turno = 'turno';
}

class Grupo {
  final int? idGrupo;
  final String nombreGrupo;
  final String nombreMateria;
  final String turno;

  const Grupo({
    this.idGrupo,
    required this.nombreGrupo,
    required this.nombreMateria,
    required this.turno,
  });

  Map<String, Object?> toJson() => {
        GrupoFields.idGrupo: idGrupo,
        GrupoFields.nombreGrupo: nombreGrupo,
        GrupoFields.nombreMateria: nombreMateria,
        GrupoFields.turno: turno,
      };

  Grupo copy({
    int? idGrupo,
    String? nombreGrupo,
    String? nombreMateria,
    String? turno,
  }) =>
      Grupo(
        idGrupo: idGrupo ?? this.idGrupo,
        nombreGrupo: nombreGrupo ?? this.nombreGrupo,
        nombreMateria: nombreMateria ?? this.nombreMateria,
        turno: turno ?? this.turno,
      );

  static Grupo fromJson(Map<String, Object?> json) => Grupo(
    idGrupo: json[GrupoFields.idGrupo] as int?,
    nombreGrupo: json[GrupoFields.nombreGrupo] as String,
    nombreMateria: json[GrupoFields.nombreMateria] as String,
    turno: json[GrupoFields.turno] as String,
  );
}
