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
  final ScrollController _barra = ScrollController();

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
      body: Scrollbar(
        thumbVisibility: true,
        controller: _barra,
        thickness: 7,
        radius: const Radius.circular(20),
        child: ListView.builder(
          controller: _barra,
          itemCount: widget.db.Grupos.length,
          itemBuilder: (context, index) {
            return GrupoCarta(
                nombreGrupo: widget.db.Grupos[index][0],
                nombreMateria: widget.db.Grupos[index][1],
                numAlumnos: widget.db.Grupos[index][2],
                dias: widget.db.Grupos[index][3]);
          },
        ),
      ),
    );
  }
}
