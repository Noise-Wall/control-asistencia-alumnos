import 'package:control_asistencias/componentes/anim_carga.dart';
import 'package:control_asistencias/componentes/scrollbar.dart';
import 'package:control_asistencias/data/controladores/ctrl_grupos.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../componentes/carta_grupo.dart';
import 'grupos_add.dart';

class Grupos extends StatefulWidget {
  Grupos({super.key});

  @override
  State<Grupos> createState() => _GruposState();
}

class _GruposState extends State<Grupos> {
  bool isLoading = false;
  late List<Grupo> grupos;

  Future refreshGrupos() async {
    setState(() => isLoading = true);
    grupos = await CtrlGrupos().readGrupoAll();
    if (dotenv.maybeGet("DEV") != null) {
      if (grupos.isEmpty) {
        const grupo = Grupo(
          nombreGrupo: "Grupo de prueba",
          nombreMateria: "Materia de prueba",
          turno: "Matutino",
        );
        CtrlGrupos().createGrupo(grupo);
        grupos = await CtrlGrupos().readGrupoAll();
      }
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    refreshGrupos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (gruposContext) => const GrupoAdd(),
            ),
          ).then((value) => refreshGrupos());
        },
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const AnimCarga()
          : grupos.isEmpty
              ? const Center(child: Text("No hay grupos"))
              : BarraDesplazo(
                  items: grupos.length,
                  itemABuildear: (context, index) => GrupoCarta(
                    idGrupo: grupos[index].idGrupo ?? 0,
                    nombreGrupo: grupos[index].nombreGrupo,
                    nombreMateria: grupos[index].nombreMateria,
                    turno: grupos[index].turno,
                    numAlumnos: 1,
                    dias: const [true, true, true, true, true, true, true],
                    refresh: (value) => refreshGrupos(),
                  ),
                ),
    );
  }
}
