import 'package:control_asistencias/componentes/anim_carga.dart';
import 'package:control_asistencias/componentes/boton.dart';
import 'package:control_asistencias/componentes/modal.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';
import 'package:flutter/material.dart';

class HorariosView extends StatefulWidget {
  final int id;

  const HorariosView({super.key, required this.id});

  @override
  State<HorariosView> createState() => _HorariosViewState();
}

class _HorariosViewState extends State<HorariosView> {
  late List<Horario> _horarios;
  bool isLoading = false;

  Future getHorarios() async {
    setState(() => isLoading = true);
    _horarios = await CtrlHorarios().readHorarioFromGrupo(widget.id);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getHorarios().then((value) => print(_horarios.isEmpty));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Horarios de {grupo} "),
          centerTitle: true,
        ),
        body: Container(
          child: isLoading
              ? const AnimCarga()
              : _horarios.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Este grupo no tiene horarios."),
                          Container(height: 10),
                          Boton(
                              texto: "Agregar horario",
                              onPresionado: () => Modal(
                                    context,
                                    ContenidoModal(),
                                    true,
                                  ))
                        ],
                      ),
                      // child: Text("Este grupo no tiene horarios."),
                    )
                  : const Text("Lista de horarios"),
        ));
  }
}

class ContenidoModal extends StatefulWidget {
  ContenidoModal({super.key});

  @override
  State<ContenidoModal> createState() => _ContenidoModalState();
}

class _ContenidoModalState extends State<ContenidoModal> {
  final TimeOfDay _hora = TimeOfDay.now();

  Future<void> _seleccionarHora(BuildContext context) async {
    TimeOfDay? seleccion = await showTimePicker(
        context: context,
        initialTime: _hora, builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (seleccion != null && seleccion != _hora) {
      setState(() {
        seleccion = _hora;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("true"),
        ],
      ),
    );
  }
}
