import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:control_asistencias/componentes/confirmar_borrado.dart';
import 'package:control_asistencias/componentes/modal.dart';
import 'package:control_asistencias/data/controladores/ctrl_horarios.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:control_asistencias/paginas/pagina_principal/horarios_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../data/modelos/horarios.dart';

class CartaHorario extends StatelessWidget {
  final Grupo grupo;
  final Future<void> Function(dynamic) refresh;

  List<Horario>? horarios = [];
  final List<bool> _dias = [];

  CartaHorario({
    super.key,
    required this.grupo,
    this.horarios,
    required this.refresh,
  });

  bool getDias(int dia) {
    if (horarios == null) return false;
    if (horarios!.any((horario) => horario.dia == dia)) return true;
    return false;
  }

  void poblarDias() {
    for (int i = 0; i < 6; i++) {
      _dias.add(getDias(i));
    }
  }  
  
  TextStyle letraDia(condicion, contexto) {
    return TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: condicion
          ? Colors.indigo
          : AdaptiveTheme.of(contexto).mode == AdaptiveThemeMode.light
              ? Colors.black12
              : Colors.white24,
    );
  }

  @override
  Widget build(BuildContext context) {
    poblarDias();
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (horarioContext) => HorariosView(id: grupo.idGrupo ?? 0),
          ),
        ).then((value) => refresh);
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: horarios!.isNotEmpty
                    ? (contexto) async => Modal(
                            contexto,
                            ConfirmarBorrado(
                                accion: CtrlHorarios().deleteHorarioFromGrupo(
                                    horarios![0].idGrupo),
                                objeto: "horario",
                                contextoInicial: context))
                        .then(refresh)
                    : (contexto) {},
                icon: Icons.delete_rounded,
                backgroundColor:
                    horarios!.isNotEmpty ? Colors.red.shade400 : Colors.white38,
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
                      Text(grupo.nombreGrupo,
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade600,
                          )),
                      Text(grupo.nombreMateria,
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade600,
                          )),
                      horarios == null
                          ? const Text(
                              "No hay horarios.",
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("L", style: letraDia(_dias[0], context)),
                                Text("M", style: letraDia(_dias[1], context)),
                                Text("M", style: letraDia(_dias[2], context)),
                                Text("J", style: letraDia(_dias[3], context)),
                                Text("V", style: letraDia(_dias[4], context)),
                                Text("S", style: letraDia(_dias[5], context)),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
