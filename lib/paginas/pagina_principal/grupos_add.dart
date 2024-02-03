import 'package:control_asistencias/componentes/boton.dart';
import 'package:control_asistencias/data/controladores/ctrl_grupos.dart';
import 'package:control_asistencias/data/modelos/grupos.dart';
import 'package:flutter/material.dart';

import 'grupos.dart';

class GrupoAdd extends StatefulWidget {
  final Grupo? grupo;

  const GrupoAdd({super.key, this.grupo});

  @override
  State<GrupoAdd> createState() => _GrupoAddState();
}

class _GrupoAddState extends State<GrupoAdd> {
  final _ctrlGrupos = CtrlGrupos();

  // controladores para la insercion de datos
  final _nombreGrupoCtrl = TextEditingController();
  final _nombreMateriaCtrl = TextEditingController();
  String? _turnoCtrl;

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
  void crearEditarGrupo() async {
    if (_formKey.currentState!.validate()) {
      if (widget.grupo != null) {
        print("update");
        final grupo = widget.grupo!.copy(
          idGrupo: widget.grupo!.idGrupo,
          nombreGrupo: _nombreGrupoCtrl.text,
          nombreMateria: _nombreMateriaCtrl.text,
          turno: _turnoCtrl.toString(),
        );
        await _ctrlGrupos.updateGrupo(grupo);
        Navigator.pop(context, _ctrlGrupos.readGrupoAll());
      } else {
        final grupo = Grupo(
          nombreGrupo: _nombreGrupoCtrl.text,
          nombreMateria: _nombreMateriaCtrl.text,
          turno: _turnoCtrl.toString(),
        );
        await _ctrlGrupos.createGrupo(grupo);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _nombreGrupoCtrl.text = widget.grupo?.nombreGrupo ?? '';
    _nombreMateriaCtrl.text = widget.grupo?.nombreMateria ?? '';
    _turnoCtrl = widget.grupo?.turno ?? 'Matutino';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir grupo"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 35.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // campo de grupo
              TextFormField(
                controller: _nombreGrupoCtrl,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Nombre del grupo:",
                  hintText: "e.g. LISI-4, LI-2...",
                ),
                validator: campoValidador,
              ),
              // campo de materia
              TextFormField(
                controller: _nombreMateriaCtrl,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Materia:",
                    hintText: "Nombre de la materia, e.g. Programación..."),
                validator: campoValidador,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("Matutino"),
                    leading: Radio<String>(
                      value: "Matutino",
                      groupValue: _turnoCtrl,
                      onChanged: (String? turno) {
                        setState(() {
                          _turnoCtrl = turno;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Vespertino"),
                    leading: Radio<String>(
                      value: "Vespertino",
                      groupValue: _turnoCtrl,
                      onChanged: (String? turno) {
                        setState(() {
                          _turnoCtrl = turno;
                        });
                      },
                    ),
                    selected: true,
                  ),
                  ListTile(
                    title: const Text("Nocturno"),
                    leading: Radio<String>(
                      value: "Nocturno",
                      groupValue: _turnoCtrl,
                      onChanged: (String? turno) {
                        setState(() {
                          _turnoCtrl = turno;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // fila de botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Boton(
                    texto: "Guardar",
                    onPresionado: crearEditarGrupo,
                  ),
                  Boton(
                    texto: "Cancelar",
                    onPresionado: Navigator
                        .of(context)
                        .pop,
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
