import 'package:control_asistencias/componentes/boton.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';
import 'package:flutter/material.dart';

enum DiaSemana {
  lunes('Lun', 0),
  martes('Mar', 1),
  miercoles('Mie', 2),
  jueves('Jue', 3),
  viernes('Vie', 4),
  sabado('Sab', 5);

  final String dia;
  final int pos;

  const DiaSemana(this.dia, this.pos);
}

class HorariosAdd extends StatefulWidget {
  final int idGrupo;
  int? idHorario;
  TimeOfDay? hora;
  int? dia;

  HorariosAdd(
      {super.key, required this.idGrupo, this.idHorario, this.hora, this.dia});

  @override
  State<HorariosAdd> createState() => _HorariosAddState();
}

class _HorariosAddState extends State<HorariosAdd> {
  late TimeOfDay _hora;
  final TextEditingController seleccionCtrl = TextEditingController();

  Future<void> _seleccionarHora(BuildContext context) async {
    TimeOfDay? seleccion = await showTimePicker(
        context: context,
        initialTime: _hora,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (seleccion != null && seleccion != _hora) {
      setState(() {
        _hora = seleccion;
        print(_hora.toString());
      });
    }
  }

  String minutero(int minutos) {
    if (minutos > 9) return minutos.toString();
    return "0$minutos";
  }

  Future<void> agregarEditarHorario(int id, int dia, TimeOfDay hora) async {
    double horaFloat = hora.hour + (hora.minute / 60);
    Horario horario = Horario(idHorario: widget.idHorario, idGrupo: id, dia: dia, hora: horaFloat);
    if (widget.idHorario != null) {
      print("in edit mode");
      await CtrlHorarios().updateHorario(horario);
    } else {
      await CtrlHorarios().createHorario(horario);
    }
  }

  void selectDia(int dia) {
    print("dia: $dia");
    setState(() {
      widget.dia = dia;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _hora = widget.hora ?? TimeOfDay.now();
      widget.dia = widget.dia ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Horario: ",
              style: TextStyle(
                fontSize: 18,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text("${_hora.hourOfPeriod}:${minutero(_hora.minute)} ${_hora.hour > 12 ? 'PM' : 'AM'}"),
            Boton(
              onPresionado: () => _seleccionarHora(context),
              texto:
                  "${_hora.hourOfPeriod}:${minutero(_hora.minute)} ${_hora.hour > 12 ? 'PM' : 'AM'}",
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
          child: Center(
            // padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<DiaSemana>(
              initialSelection: widget.dia != null
                  ? DiaSemana.values[widget.dia!]
                  : DiaSemana.lunes,
              controller: seleccionCtrl,
              label: const Text("Día de la semana:",
                  style: TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.bold)),
              leadingIcon: const Icon(Icons.calendar_today),
              onSelected: (DiaSemana? diaSemana) {
                setState(() => widget.dia = diaSemana?.pos);
              },
              dropdownMenuEntries: DiaSemana.values
                  .map<DropdownMenuEntry<DiaSemana>>((DiaSemana diaSemana) {
                return DropdownMenuEntry<DiaSemana>(
                    value: diaSemana,
                    label: diaSemana.dia,
                    style: MenuItemButton.styleFrom(
                      foregroundColor: Colors.indigo,
                    ));
              }).toList(),
            ),
            // child: Wrap(
            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   spacing: 4.0,
            //   children: [
            //     CuadroVerifica(
            //       valor: widget.dias![0],
            //       titulo: "Lun",
            //     ),
            //     CuadroVerifica(
            //       valor: widget.dias![1],
            //       titulo: "Mar",
            //     ),
            //     CuadroVerifica(
            //       valor: widget.dias![2],
            //       titulo: "Mie",
            //     ),
            //     CuadroVerifica(
            //       valor: widget.dias![3],
            //       titulo: "Jue",
            //     ),
            //     CuadroVerifica(
            //       valor: widget.dias![4],
            //       titulo: "Vie",
            //     ),
            //     CuadroVerifica(
            //       valor: widget.dias![5],
            //       titulo: "Sab",
            //     ),
            //   ],
            // ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Boton(
              texto:
                  "${widget.idHorario != null ? "Cambiar" : "Agregar"} Horario",
              onPresionado: () {
                agregarEditarHorario(widget.idGrupo, widget.dia!, _hora);
                Navigator.of(context).pop();
              },
            ),
            Boton(
                texto: "Cancelar",
                onPresionado: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ],
    );
  }
}
