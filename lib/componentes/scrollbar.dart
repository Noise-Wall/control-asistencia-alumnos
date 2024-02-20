import 'package:flutter/material.dart';

class BarraDesplazo extends StatelessWidget {
  final int items;
  final Widget? Function(BuildContext, int) itemABuildear;
  final Widget? itemInicio;
  final Widget? itemFin;
  BarraDesplazo(
      {super.key,
      required this.items,
      required this.itemABuildear,
      this.itemInicio,
      this.itemFin});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _controller,
      thickness: 7,
      radius: const Radius.circular(20),
      child: ListView(children: <Widget>[
        if (itemInicio != null) itemInicio!,
        ListView.builder(
          controller: _controller,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items,
          itemBuilder: itemABuildear,
        ),
        if (itemFin != null) itemFin!,
      ]),
    );
  }
}
