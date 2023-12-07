import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/localdb.dart';
import 'grupos.dart';
import 'horarios.dart';
import 'inicio.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  ThemeMode _themeMode = ThemeMode.system;
  // el index de la pagina seleccionada. para llevar rastreo de pagina actual.
  int _paginaSeleccionada = 0;

  // declaracion de la base de datos local.
  final _asistencias = Hive.box('Asistencias');
  static AsistenciasDB db = AsistenciasDB();

  // lista de paginas de la barra de navegacion inferior.
  final List _paginas = [
    Inicio(db: db),
    Grupos(db: db),
    Horarios(db: db),
  ];

  // inicializacion de la base de datos
  @override
  void initState() {
    if (_asistencias.get("GRUPOS") == null) {
      db.crearGrupoPrueba();
    } else {
      db.loadGrupos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página principal"),
        centerTitle: true,
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
