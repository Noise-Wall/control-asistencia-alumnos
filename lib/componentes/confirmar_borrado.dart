import "package:flutter/material.dart";

import "boton.dart";

class ConfirmarBorrado extends StatelessWidget {
  final Future accion;
  final String texto;
  final BuildContext contextoInicial;

  ConfirmarBorrado(
      {super.key,
      required this.accion,
      required this.texto,
      required this.contextoInicial});

  bool _confirmarBorrado = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "ADVERTENCIA",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          texto,
          style: const TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.left,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Boton(
              texto: "Sí, borrar",
              onPresionado: () {
                if (!_confirmarBorrado) {
                  _confirmarBorrado = true;
                } else {
                  _confirmarBorrado = false;
                  accion;
                  Navigator.of(context).pop();
                }
              },
              colorBoton: Colors.red,
            ),
            Boton(
                texto: "Cancelar",
                onPresionado: () {
                  _confirmarBorrado = false;
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ],
    );
  }
}
