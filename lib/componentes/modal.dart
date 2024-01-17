import 'package:flutter/material.dart';

Future Modal(BuildContext context, Widget contenido, [bool dismissable = false]) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    // isDismissable false para que la confirmacion para borrar sea mas segura.
    isDismissible: dismissable,
    context: context,
    builder: (modalContext) => Container(
      height: 350,
      padding: const EdgeInsets.all(25),
      child: contenido,
    ),
  );
}
