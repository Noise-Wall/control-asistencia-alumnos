import 'dart:io';

import 'package:control_asistencias/paginas/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:sqflite_common_ffi/sqflite_ffi.dart";

void main() async {
  // Carga archivo de variables ambientales, como hashes, contrasenas y otros.
  // Por su naturaleza sensible, este archivo no se sube al GitHub.
  // Si no tienen el archivo .env, pidanmelo.
  if (Platform.isWindows || Platform.isLinux) {
   sqfliteFfiInit();
  }

  databaseFactory = databaseFactoryFfi;

  await dotenv.load(fileName: ".env");
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
      home: const PaginaPrincipal(),
    );
  }
}
