import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/localdb.dart';

class Inicio extends StatelessWidget {
  final AsistenciasDB db;
  final _asistencias = Hive.box('Asistencias');

  Inicio({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Bienvenido, ${db.Profesor}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                      "Actualmente tiene ${db.Grupos.length} ${db.Grupos.length == 1 ? "grupo" : "grupos"}."),
                  Text("Actualmente imparte ${db.Grupos} horas de clase."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
