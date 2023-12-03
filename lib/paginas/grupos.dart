import 'package:flutter/material.dart';

import '../componentes/carta_grupo.dart';
import '../data/localdb.dart';

class Grupos extends StatelessWidget {
  final AsistenciasDB db;
  const Grupos({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Pressed on Grupos"),
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: db.Grupos.length,
        itemBuilder: (context, index) {
          return GrupoCarta(
              nombreGrupo: db.Grupos[index][0],
              nombreMateria: db.Grupos[index][1],
              numAlumnos: db.Grupos[index][2],
              dias: db.Grupos[index][3]);
        },
      ),
    );
  }
}
