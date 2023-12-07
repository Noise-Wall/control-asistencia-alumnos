import 'package:flutter/material.dart';

import '../componentes/carta_grupo.dart';
import '../paginas/grupos_add.dart';
import '../data/localdb.dart';

class Grupos extends StatefulWidget {
  final AsistenciasDB db;

  Grupos({super.key, required this.db});

  @override
  State<Grupos> createState() => _GruposState();
}

class _GruposState extends State<Grupos> {
  void crearGrupo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GrupoAdd(
              db: widget.db,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: widget.db.Grupos.length,
        itemBuilder: (context, index) {
          return GrupoCarta(
              nombreGrupo: widget.db.Grupos[index][0],
              nombreMateria: widget.db.Grupos[index][1],
              numAlumnos: widget.db.Grupos[index][2],
              dias: widget.db.Grupos[index][3]);
        },
      ),
    );
  }
}
