import 'package:control_asistencias/componentes/boton.dart';
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

  bool _confirmarBorrado = false;

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
              backgroundColor: Colors.cyan.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: (contexto) => Modal(
                  contexto,
                  Column(
                    children: [
                      const Text(
                        "ADVERTENCIA",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Text(
                        '''Esta acción eliminará el grupo y toda la información que contenga.
¿Realmente desea borrar el grupo?
Presione \"Sí, borrar\" dos veces para borrar el grupo.
                        ''',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Boton(
                            texto: "Sí, borrar",
                            onPresionado: () {
                              if (!_confirmarBorrado) {
                                _confirmarBorrado = true;
                              } else {
                                _confirmarBorrado = false;
                                CtrlGrupos().deleteGrupo(idGrupo);
                                Navigator.of(context).pop();
                              }
                            },
                            colorBoton: Colors.red,
                          ),
                          Boton(
                              texto: "Cancelar",
                              onPresionado: () {
                                _confirmarBorrado = false;
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    ],
                  )).then(refresh),
              icon: Icons.delete_rounded,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
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
                          color: Colors.black26,
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
