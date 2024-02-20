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
  final int? sesiones;
  final Future<void> Function(dynamic) refresh;

  GrupoCarta({
    super.key,
    required this.idGrupo,
    required this.nombreGrupo,
    required this.nombreMateria,
    required this.turno,
    required this.numAlumnos,
    this.sesiones,
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
              onPressed: (context) async => Modal(
                context,
                GrupoAdd(
                    grupo: Grupo(
                        idGrupo: idGrupo,
                        nombreGrupo: nombreGrupo,
                        nombreMateria: nombreMateria,
                        turno: turno)),
                true,
              ).then(refresh),
              icon: Icons.edit_rounded,
              backgroundColor: const Color.fromRGBO(57, 73, 171, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            SlidableAction(
              onPressed: (contexto) async => Modal(
                      contexto,
                      ConfirmarBorrado(
                          accion: CtrlGrupos().deleteGrupo(idGrupo),
                          texto:
                              '''Esta acción eliminará el grupo y toda la información que contenga.
¿Realmente desea borrar el grupo?
Presione "Sí, borrar" dos veces para borrar el grupo.
''',
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
                    Row(
                      children: [
                        Icon(Icons.brightness_4,
                            color: Colors.amber.shade600.withRed(200)),
                        Text(
                          turno,
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            color: Colors.indigo.shade300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.group,
                          color: Colors.indigo,
                        ),
                        Text(
                          numAlumnos.toString(),
                          style: const TextStyle(
                            color: Colors.indigo,
                          ),
                        ),
                        const Icon(
                          Icons.schedule,
                          color: Colors.indigo,
                        ),
                        Text(
                          sesiones.toString(),
                          style: const TextStyle(
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
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
