import 'package:control_asistencias/data/localdb.dart';
import 'package:flutter/material.dart';

class Horarios extends StatelessWidget {
  final AsistenciasDB db;
  const Horarios({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Horarios"),
      ),
    );
  }
}
