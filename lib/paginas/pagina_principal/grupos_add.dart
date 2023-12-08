import 'package:control_asistencias/componentes/boton.dart';
import 'package:flutter/material.dart';

import '../../data/localdb.dart';

class GrupoAdd extends StatefulWidget {
  final AsistenciasDB db;

  GrupoAdd({
    super.key,
    required this.db,
  });

  @override
  State<GrupoAdd> createState() => _GrupoAddState();
}

class _GrupoAddState extends State<GrupoAdd> {
  // controladores para la insercion de datos
  final _grupoCtrl = TextEditingController();

  final _materiaCtrl = TextEditingController();

  // clave identificadora de este formulario
  final _formKey = GlobalKey<FormState>();

  // el validador para los campos de texto.
  String? campoValidador(value) {
    if (value == null || value.isEmpty) {
      return 'Por favor llene todos los campos.';
    }
    return null;
  }

  // accion al validarse con exito el formulario. agrega un grupo nuevo.
  void crearGrupo() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.db.Grupos.add([
          _grupoCtrl.text,
          _materiaCtrl.text,
          0,
          [false, false, false, false, false, false, false]
        ]);
      });
      Navigator.of(context).pop();
      widget.db.updateGrupos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir grupo"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 35.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // campo de grupo
              TextFormField(
                controller: _grupoCtrl,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Nombre del grupo:",
                  hintText: "e.g. LISI-4, LI-2...",
                ),
                validator: campoValidador,
              ),
              // campo de materia
              TextFormField(
                controller: _materiaCtrl,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Materia:",
                    hintText: "Nombre de la materia, e.g. Programación..."),
                validator: campoValidador,
              ),
              // fila de botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Boton(
                    texto: "Guardar",
                    onPresionado: crearGrupo,
                  ),
                  Boton(
                    texto: "Cancelar",
                    onPresionado: Navigator.of(context).pop,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
