import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:control_asistencias/componentes/confirmar_borrado.dart';
import 'package:control_asistencias/componentes/modal.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:control_asistencias/data/controladores/ctrl_grupos.dart';
import 'package:control_asistencias/paginas/pagina_principal/grupos_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GrupoCarta extends StatelessWidget {
  final int idGrupo;
  final String nombreGrupo;
  final String nombreMateria;
  final String turno;

  final int numAlumnos;
  final List<bool> dias;
  final Future<void> Function(dynamic) refresh;

  GrupoCarta({
    super.key,
    required this.idGrupo,
    required this.nombreGrupo,
    required this.nombreMateria,
    required this.turno,
    required this.numAlumnos,
    required this.dias,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GrupoAdd(
                      grupo: Grupo(
                          idGrupo: idGrupo,
                          nombreGrupo: nombreGrupo,
                          nombreMateria: nombreMateria,
                          turno: turno)),
                ),
              ).then(refresh),
              icon: Icons.edit_rounded,
              backgroundColor: const Color.fromRGBO(57, 73, 171, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            SlidableAction(
              onPressed: (contexto) => Modal(
                      contexto,
                      ConfirmarBorrado(
                          accion: CtrlGrupos().deleteGrupo(idGrupo),
                          objeto: "grupo",
                          contextoInicial: context))
                  .then(refresh),
              icon: Icons.delete_rounded,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                ? Colors.white
                : null,
            border: Border.all(color: Colors.indigo, width: 2.0),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombreGrupo,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade600,
                        )),
                    Text(nombreMateria,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade600,
                        )),
                    Text(turno,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          color: Colors.indigo.shade300,
                        )),
                    Text(
                        "$numAlumnos alumnos, ${dias.fold(0, (previous, element) => element == true ? previous + 1 : previous)} dias a la semana",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            // color: Colors.black26,
                            )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
