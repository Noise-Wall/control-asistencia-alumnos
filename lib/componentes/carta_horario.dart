import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../data/modelos/horarios.dart';

class CartaHorario extends StatelessWidget {
  final nombreGrupo;
  final nombreMateria;
  List<Horario>? horarios = [];

  // List<Horario> horarios = [
  // Horario(idGrupo: 1, dia: 0, hora: 1),
  // Horario(idGrupo: 2, dia: 2, hora: 1),
  // Horario(idGrupo: 3, dia: 5, hora: 1),
  // ];
  final List<bool> _dias = [];

  CartaHorario({
    super.key,
    required this.nombreGrupo,
    required this.nombreMateria,
    this.horarios,
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
    print(_dias.join(", "));
  }

  // List<Horario> pruebas = [
  //   Horario(idGrupo: 1, dia: 0, hora: 1),
  //   Horario(idGrupo: 2, dia: 2, hora: 1),
  //   Horario(idGrupo: 3, dia: 5, hora: 1),
  // ];

  TextStyle letraDia(condicion) {
    return TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: condicion ? Colors.indigo : Colors.black12,
    );
  }

  @override
  Widget build(BuildContext context) {
    poblarDias();
    return Container(
      padding: const EdgeInsets.all(25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => print("pressed"),
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
                    horarios == null
                        ? const Text(
                            "No hay horarios.",
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("L", style: letraDia(_dias?[0])),
                              Text("M", style: letraDia(_dias?[1])),
                              Text("M", style: letraDia(_dias?[2])),
                              Text("J", style: letraDia(_dias?[3])),
                              Text("V", style: letraDia(_dias?[4])),
                              Text("S", style: letraDia(_dias?[5])),
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
