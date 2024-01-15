import 'package:flutter/material.dart';

Future Modal(BuildContext context, Widget contenido) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    // isDismissable false para que la confirmacion para borrar sea mas segura.
    isDismissible: false,
    context: context,
    builder: (context) => Container(
      height: 350,
      padding: const EdgeInsets.all(25),
      child: contenido,
    ),
  );
}
