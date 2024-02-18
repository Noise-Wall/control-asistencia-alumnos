import 'package:control_asistencias/componentes/anim_carga.dart';
import 'package:control_asistencias/componentes/carta_horario.dart';
import 'package:control_asistencias/componentes/scrollbar.dart';
import 'package:control_asistencias/data/controladores/ctrl_grupos.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:control_asistencias/data/modelos/horarios.dart';
import 'package:control_asistencias/paginas/pagina_principal/horarios_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Horarios extends StatefulWidget {
  const Horarios({super.key});

  @override
  State<Horarios> createState() => _HorariosState();
}

class _HorariosState extends State<Horarios> {
  bool isLoading = false;
  late List<Grupo> grupos;
  final List<List<Horario>> horarios = [];

  Future refreshHorarios() async {
    setState(() => isLoading = true);
    grupos = await CtrlGrupos().readGrupoAll();
    if (grupos.isNotEmpty) {
      for (var grupo in grupos) {
        final horario =
            await CtrlHorarios().readHorarioFromGrupo(grupo.idGrupo!);
        horarios.add(horario);
      }
      grupos = await CtrlGrupos().readGrupoAll();
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    refreshHorarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const AnimCarga()
          : horarios.isEmpty
              ? const Center(
                  child:
                      Text("No hay grupos. Agregue grupos para ver horarios."))
              : BarraDesplazo(
                  items: grupos.length,
                  itemABuildear: (context, index) => CartaHorario(
                      grupo: grupos[index],
                      horarios: horarios[index],
                      refresh: (value) => refreshHorarios()),
                  // itemABuildear: (context, index) => InkWell(
                  //   onTap: () async {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (horarioContext) =>
                  //             HorariosView(id: grupos[index].idGrupo ?? 0),
                  //       ),
                  //     ).then((value) => refreshHorarios());
                  //   },
                  //   child: CartaHorario(
                  //     nombreGrupo: grupos[index].nombreGrupo,
                  //     nombreMateria: grupos[index].nombreMateria,
                  //     horarios: horarios[index],
                  //     refresh: (value) => refreshHorarios(),
                  //   ),
                  // ),
                ),
    );
    // return Column(
    //   children: [
    //     Text(grupos[index].nombreGrupo),
    //     Text(grupos[index].nombreMateria),
    //     horarios[index].isNotEmpty
    //       ? Text(horarios[index].length.toString())
    //       : Text("Este grupo no tiene horarios."),
    //   ],
    // );
  }
}
