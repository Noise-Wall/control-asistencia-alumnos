import 'package:control_asistencias/componentes/boton.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';
import 'package:flutter/material.dart';

class HorariosAdd extends StatefulWidget {
  final int idGrupo;
  TimeOfDay? hora;
  int? dia;

  HorariosAdd({super.key, required this.idGrupo, this.hora, this.dia});

  @override
  State<HorariosAdd> createState() => _HorariosAddState();
}

class _HorariosAddState extends State<HorariosAdd> {
  late TimeOfDay _hora;

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

  Future<void> agregarHorario(int id, int dia, TimeOfDay hora) async {
    double horaFloat = hora.hour + (hora.minute / 60);
    Horario horario =
    Horario(idGrupo: id, dia: dia, hora: horaFloat);
    await CtrlHorarios().createHorario(horario);
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
        const Text(
          "Dia de la semana: ",
          style: TextStyle(
            fontSize: 18,
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                title: const Text(
                  "Lun",
                ),
                leading: Radio<int>(
                  value: 0,
                  groupValue: widget.dia!,
                  onChanged: (int? nuevoDia) => selectDia(nuevoDia ?? 0),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text(
                  "Mar",
                ),
                leading: Radio<int>(
                  value: 1,
                  groupValue: widget.dia!,
                  onChanged: (int? nuevoDia) => selectDia(nuevoDia ?? 1),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text(
                  "Mié",
                ),
                leading: Radio<int>(
                  value: 2,
                  groupValue: widget.dia!,
                  onChanged: (int? nuevoDia) => selectDia(nuevoDia ?? 2),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                title: const Text(
                  "Jue",
                ),
                leading: Radio<int>(
                  value: 3,
                  groupValue: widget.dia!,
                  onChanged: (int? nuevoDia) => selectDia(nuevoDia ?? 3),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text(
                  "Vie",
                ),
                leading: Radio<int>(
                  value: 4,
                  groupValue: widget.dia!,
                  onChanged: (int? nuevoDia) => selectDia(nuevoDia ?? 4),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text(
                  "Sáb",
                ),
                leading: Radio<int>(
                  value: 5,
                  groupValue: widget.dia!,
                  onChanged: (int? nuevoDia) => selectDia(nuevoDia ?? 5),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Boton(
              texto: "Agregar Horario",
              onPresionado: () {
                agregarHorario(widget.idGrupo, widget.dia!, _hora);
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
