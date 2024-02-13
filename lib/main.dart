import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:control_asistencias/paginas/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:sqflite_common_ffi/sqflite_ffi.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Carga archivo de variables ambientales, como hashes, contrasenas y otros.
  // Por su naturaleza sensible, este archivo no se sube al GitHub.
  // Si no tienen el archivo .env, pidanmelo.
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;
  }

  await dotenv.load(fileName: ".env");

  // obtiene el tema del sistema.
  final tema = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(temaGuardado: tema));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, AdaptiveThemeMode? temaGuardado});
  AdaptiveThemeMode? temaGuardado;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      dark: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      initial: temaGuardado ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Control de Asistencias',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const PaginaPrincipal(),
      ),
    );
  }
}
