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
      bottomNavigationBar: NavigationBar(
        // funcion para actualizar la pagina actual.
        selectedIndex: _paginaSeleccionada,
        onDestinationSelected: (int index) => setState(() {
          _paginaSeleccionada = index;
        }),
        backgroundColor: Colors.amber.shade600.withRed(200),
        indicatorColor: Colors.indigo.shade600,
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.indigo.shade600,),
            label: "Inicio",
            selectedIcon: Icon(Icons.home, color: Colors.white,),
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined, color: Colors.indigo.shade600),
            label: "Grupos",
            selectedIcon: Icon(Icons.people_alt, color: Colors.white,),
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined, color: Colors.indigo.shade600),
            label: "Horarios",
            selectedIcon: Icon(Icons.access_time, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
