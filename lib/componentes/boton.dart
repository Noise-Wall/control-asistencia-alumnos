import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final String texto;
  VoidCallback onPresionado;
  Color? colorBoton;

  Boton({
    super.key,
    required this.texto,
    required this.onPresionado,
    this.colorBoton,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPresionado,
      color: colorBoton ?? Colors.indigo,
      shape: const StadiumBorder(),
      child: Text(texto),
      textColor: Colors.white,
    );
  }
}