import 'package:control_asistencias/componentes/anim_carga.dart';
import 'package:control_asistencias/componentes/boton.dart';
import 'package:control_asistencias/componentes/modal.dart';
import 'package:control_asistencias/componentes/scrollbar.dart';
import 'package:control_asistencias/data/controladores/ctrl_grupos.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';
import 'package:control_asistencias/paginas/pagina_principal/horarios_add.dart';
import 'package:flutter/material.dart';

class HorariosView extends StatefulWidget {
  final int id;

  const HorariosView({
    super.key,
    required this.id,
  });

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

  String convertHora(double horario) {
    int hora = horario.floor();
    int minutos = ((horario - hora) * 60).round();
    TimeOfDay tiempo = TimeOfDay(hour: horario.floor(), minute: minutos);

    return "${hora <= 9 ? '0' : ''}${hora}:${minutos}${minutos <= 9 ? '0' : ''}";
  }

  TimeOfDay getTimeOfDay(double horario) {
    int minutos = ((horario - horario.floor()) * 60).round();
    return TimeOfDay(hour: horario.floor(), minute: minutos);
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
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pop(context, CtrlGrupos().readGrupoAll())),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () => Modal(
          context,
          HorariosAdd(
            idGrupo: widget.id,
          ),
          true,
        ).then((value) => getHorarios()),
        label: const Row(
            children: [Icon(Icons.more_time), Text("Agregar horario")]),
      ),
      body: Container(
        child: isLoading
            ? const AnimCarga()
            : _horarios.isEmpty
                ? const Center(
                    child: Text("Este grupo no tiene horarios."),
                  ) // : const Text("Lista de horarios"),
                : BarraDesplazo(
                    items: _horarios.length,
                    itemABuildear: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 50),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: InkWell(
                              onTap: () => Modal(
                                context,
                                HorariosAdd(
                                  idHorario: _horarios[index].idHorario,
                                  idGrupo: widget.id,
                                  hora: getTimeOfDay(_horarios[index].hora),
                                  dia: _horarios[index].dia,
                                ),
                                true,
                              ).then((value) => getHorarios()),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  border: Border.all(
                                      color: Colors.indigo, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${_dias[_horarios[index].dia]}, a las ${convertHora(_horarios[index].hora)}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox(width: 2)),
                          Expanded(
                            flex: 2,
                            child: Boton(
                              texto: "Eliminar",
                              onPresionado: () => print("pressed"),
                              colorBoton: Colors.redAccent,
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox(width: 2)),
                        ],
                      ),
                    ),
                    // espacio en blanco al final para que el scroll pueda irse extra
                    itemFin: const SizedBox(height: 65),
                  ),
        // child: Text("Este grupo no tiene horarios."),
      ),
    );
  }
}
// Boton(
//                       texto: "Agregar horario",
//                       
//                     ),