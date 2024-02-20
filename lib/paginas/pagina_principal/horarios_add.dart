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
  final TextEditingController _hora = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController seleccionCtrl = TextEditingController();

  Future<void> _seleccionarHora(BuildContext context) async {
    TimeOfDay? seleccion = await showTimePicker(
        context: context,
        initialTime: widget.hora ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (seleccion != null) {
      setState(() {
        _hora.text = seleccion.format(context);
        print(_hora.text);
      });
    }
  }

  void refreshHora() {
    if (widget.hora != null) {
      setState(()=> 
        _hora.text = widget.hora!.format(context)
      );
    }
  }

  Future<int?> agregarEditarHorario(int id, int dia, String hora) async {
    // double horaFloat = hora.hour + (hora.minute / 60);
    try {
      double horaFloat = double.parse(hora.split(":")[0]) +
          (double.parse(hora.split(":")[1]) / 60);
      Horario horario = Horario(
          idHorario: widget.idHorario, idGrupo: id, dia: dia, hora: horaFloat);
      if (widget.idHorario != null) {
        print("in edit mode");
        await CtrlHorarios().updateHorario(horario);
        return null;
      } else {
        await CtrlHorarios().createHorario(horario);
        return null;
      }
    } catch (e) {
      print("El String $hora no es un horario válido.");
      return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.dia = widget.dia ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshHora();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
              icon: Icon(Icons.timer),
              labelText: "Horario:",
              labelStyle:
                  TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
              hintText: "La hora de clase."),
          controller: _hora,
          readOnly: true,
          onTap: () => _seleccionarHora(context),
          onChanged: (value) => print("changed"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserte un horario válido.';
            }
            for (final isNumber in value.split(":")) {
              if (double.tryParse(isNumber) == null) {
                return "$value no es un horario válido.";
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
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
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Boton(
              texto:
                  "${widget.idHorario != null ? "Cambiar" : "Agregar"} Horario",
              onPresionado: () async {
                int? validacion = await agregarEditarHorario(
                    widget.idGrupo, widget.dia!, _hora.text);
                if (validacion == null) Navigator.of(context).pop();
              },
            ),
            Boton(
              texto: "Cancelar",
              onPresionado: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
