import 'package:control_asistencias/componentes/anim_carga.dart';
import 'package:control_asistencias/data/controladores/ctrl_grupos.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  bool isLoading = false;
  final _ctrlGrupo = CtrlGrupos();

  int numGrupos = 0;

  Future getStats() async {
    setState(() => isLoading = true);
    numGrupos = await _ctrlGrupo.countGrupo();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
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
                            "Actualmente tiene $numGrupos ${numGrupos != 1 ? "grupos" : "grupo"}."),
                        Text("Actualmente imparte (HORAS) horas de clase."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
