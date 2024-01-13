/// Modelo para la tabla de horarios.
///
/// La tabla horarios tiene una relacion M-1 con la tabla Grupos, cada entrada
/// del horario representando una clase por dia.
///
/// La columna "dia" es un entero por dia de la semana, empezando por lunes = 0,
/// martes = 1, etc. y finalizando en sabado = 5.
///
/// La columna "hora" es un flotante que representa la hora. El programa hara
/// la conversion de los minutos dentro de la aplicacion de acuerdo a los
/// decimales: .5 serian 30 minutos, .25, 15 minutos etc.

const String tableHorarios = 'Horarios';

class HorarioFields {
  static final List<String> values = [
    idHorario, idGrupo, dia, hora,
  ];

  static const String idHorario = '_idHorario';
  static const String idGrupo = 'idGrupo';
  static const String dia = 'dia';
  static const String hora = 'hora';
}

class Horario {
  final int? idHorario;
  final int idGrupo;
  final int dia;
  final double hora;

  const Horario({
    this.idHorario,
    required this.idGrupo,
    required this.dia,
    required this.hora,
  });

  Map<String, Object?> toJson() => {
        HorarioFields.idHorario: idHorario,
        HorarioFields.idGrupo: idGrupo,
        HorarioFields.dia: dia,
        HorarioFields.hora: hora,
      };

  Horario copy({
    int? idHorario,
    int? idGrupo,
    int? dia,
    double? hora,
  }) =>
      Horario(
        idHorario: idHorario ?? this.idHorario,
        idGrupo: idGrupo ?? this.idGrupo,
        dia: dia ?? this.dia,
        hora: hora ?? this.hora,
      );

  static Horario fromJson(Map<String, Object?> json) => Horario(
    idHorario: json[HorarioFields.idHorario] as int?,
    idGrupo: json[HorarioFields.idGrupo] as int,
    dia: json[HorarioFields.dia] as int,
    hora: json[HorarioFields.hora] as double,
  );
}
