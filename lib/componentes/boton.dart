import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final String texto;
  VoidCallback onPresionado;

  Boton({
    super.key,
    required this.texto,
    required this.onPresionado,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPresionado,
      color: Colors.indigo,
      child: Text(texto),
      textColor: Colors.white,
    );
  }
}