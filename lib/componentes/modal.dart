import 'package:flutter/material.dart';

final ScrollController scrollController = ScrollController();

Future Modal(BuildContext context, Widget contenido,
    [bool dismissable = false]) {
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
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(modalContext).size.width * 0.9,
        maxHeight: MediaQuery.of(modalContext).size.height * 0.5,
      ),
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
          controller: scrollController,
          child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: contenido)),
    ),
  );
}
