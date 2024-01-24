import 'package:control_asistencias/componentes/anim_carga.dart';
import 'package:control_asistencias/componentes/boton.dart';
import 'package:control_asistencias/componentes/modal.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';
import 'package:control_asistencias/paginas/pagina_principal/horarios_add.dart';
import 'package:flutter/material.dart';

class HorariosView extends StatefulWidget {
  final int id;

  const HorariosView({super.key, required this.id});

  @override
  State<HorariosView> createState() => _HorariosViewState();
}

class _HorariosViewState extends State<HorariosView> {
  final ScrollController _barra = ScrollController();
  late List<Horario> _horarios;
  final List<String> _dias = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado"
  ];
  bool isLoading = false;

  Future getHorarios() async {
    setState(() => isLoading = true);
    _horarios = await CtrlHorarios().readHorarioFromGrupo(widget.id);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getHorarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horarios"),
        centerTitle: true,
      ),
      body: Container(
        child: isLoading
            ? const AnimCarga()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _horarios.isEmpty
                        ? const Text("Este grupo no tiene horarios.")
                        // : const Text("Lista de horarios"),
                        : ListView.builder(
                            shrinkWrap: true,
                            controller: _barra,
                            itemCount: _horarios.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Row(
                                  children: [
                                    Text(
                                        "${_dias[_horarios[index].dia]}, a las ${_horarios[index].hora}"),
                                  ],
                                ),
                              );
                            }),
                    Container(height: 10),
                    Boton(
                      texto: "Agregar horario",
                      onPresionado: () => Modal(
                        context,
                        HorariosAdd(
                          idGrupo: widget.id,
                        ),
                        true,
                      ).then((value) => getHorarios()),
                    ),
                  ],
                ),
                // child: Text("Este grupo no tiene horarios."),
              ),
      ),
    );
  }
}
