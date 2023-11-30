import 'package:flutter/material.dart';

import 'grupos.dart';
import 'horarios.dart';
import 'inicio.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  // el index de la pagina seleccionada. para llevar rastreo de pagina actual.
  int _paginaSeleccionada = 0;

  // lista de paginas de la barra de navegacion inferior.
  final List _paginas = [
    Inicio(),
    Grupos(),
    Horarios(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página principal"),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: _paginas[_paginaSeleccionada],
      // barra de navegacion inferior
      bottomNavigationBar: BottomNavigationBar(
        // funcion para actualizar la pagina actual.
        onTap: (int index) => setState(() {
          _paginaSeleccionada = index;
        }),
        fixedColor: Color(0xd5be7f),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Grupos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Horarios",
          ),
        ],
      ),
    );
  }
}
