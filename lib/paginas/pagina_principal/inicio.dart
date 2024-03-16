import 'package:control_asistencias/componentes/anim_carga.dart';
import 'package:control_asistencias/componentes/scrollbar.dart';
import 'package:control_asistencias/data/controladores/ctrl_grupos.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  bool isLoading = false;
  final _ctrlGrupo = CtrlGrupos();

  int numGrupos = 0;
  int numSesiones = 0;
  String hoy = DateFormat('EEEE').format(DateTime.now());
  late List<Map> horariosHoy;

  Future getStats() async {
    setState(() => isLoading = true);
    print("Dia es ${DateTime.now().weekday}");
    numGrupos = await _ctrlGrupo.countGrupo();
    numSesiones = await CtrlHorarios().countHorarioAll();
    horariosHoy =
        await CtrlHorarios().readHorarioFromDia(DateTime.now().weekday - 1);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    getStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const AnimCarga()
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Bienvenido",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Actualmente tiene $numGrupos ${numGrupos != 1 ? "grupos" : "grupo"}.",
                          softWrap: true,
                        ),
                        Text(
                          "Actualmente imparte $numSesiones sesiones a la semana.",
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  horariosHoy.isEmpty
                      ? const Text("No hay clases el dia de hoy.")
                      : Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.indigo),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: BarraDesplazo(
                              items: horariosHoy.length,
                              itemABuildear: (context, index) =>
                                  // Text("${horariosHoy[index].nombreGrupo}, ${horariosHoy[index].nombreMateria}")
                                  Text("${horariosHoy[index]['nombreGrupo']} - ${horariosHoy[index]['nombreMateria']} (${horariosHoy[index]['hora']})"),
                              itemInicio: Text("Clases del dia de hoy ($hoy)"),
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
