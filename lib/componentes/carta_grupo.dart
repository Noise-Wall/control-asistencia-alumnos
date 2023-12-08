import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GrupoCarta extends StatelessWidget {
  final String nombreGrupo;
  final String nombreMateria;
  final int numAlumnos;
  final List<bool> dias;

  const GrupoCarta({
    super.key,
    required this.nombreGrupo,
    required this.nombreMateria,
    required this.numAlumnos,
    required this.dias,
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
              onPressed: (context) => print("Slidable pressed"),
              icon: Icons.edit_rounded,
              backgroundColor: Colors.cyan.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: (context) => print("Slidable pressed"),
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
