import 'package:control_asistencias/paginas/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// funcion asíncrona para cargar Hive, una libreria para usar almacenamiento local.
void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('Asistencias');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Asistencias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: PaginaPrincipal(),
    );
  }
}
