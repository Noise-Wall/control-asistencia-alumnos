import 'package:control_asistencias/data/db_principal.dart';
import 'package:flutter/material.dart';

import 'pagina_principal/grupos.dart';
import 'pagina_principal/horarios.dart';
import 'pagina_principal/inicio.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  ThemeMode _themeMode = ThemeMode.system;

  // el index de la pagina seleccionada. para llevar rastreo de pagina actual.
  int _paginaSeleccionada = 0;

  // lista de paginas de la barra de navegacion inferior.
  final List _paginas = [
    const Inicio(),
    Grupos(),
    const Horarios(),
  ];

  // inicializacion de la base de datos
  @override
  void initState() {
    super.initState();
  }

  // cierra la base de datos al cerrar app
  @override
  void dispose() {
    ControlAsistenciasDB.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página principal"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      // Basicamente tododentro del Drawer es temporal.
      // A futuro se cambiará a NavigationDrawer, al igual que con el
      // BottomNavigationBar.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Colors.amber.shade600.withRed(200)),
              child:
                  const Text("Header de drawer, quiza para mostrar el perfil"),
            ),
            ListTile(
              leading: const Icon(Icons.person_2_rounded),
              title: const Text('Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.sync),
              title: const Text('Sincronización'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Pase de lista'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Estadísticas'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(ThemeMode.system == ThemeMode.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded),
              title: const Text('Cambiar tema'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: _paginas[_paginaSeleccionada],
      // barra de navegacion inferior
      bottomNavigationBar: NavigationBar(
        // funcion para actualizar la pagina actual.
        selectedIndex: _paginaSeleccionada,
        onDestinationSelected: (int index) => setState(() {
          _paginaSeleccionada = index;
        }),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: Colors.amber.shade600.withRed(200),
        indicatorColor: Colors.indigo.shade600,
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.indigo.shade600,
            ),
            label: "Inicio",
            selectedIcon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          NavigationDestination(
            icon:
                Icon(Icons.people_alt_outlined, color: Colors.indigo.shade600),
            label: "Grupos",
            selectedIcon: const Icon(
              Icons.people_alt,
              color: Colors.white,
            ),
          ),
          NavigationDestination(
            icon:
                Icon(Icons.access_time_outlined, color: Colors.indigo.shade600),
            label: "Horarios",
            selectedIcon: const Icon(
              Icons.access_time,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
