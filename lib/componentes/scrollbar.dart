import 'package:flutter/material.dart';

class BarraDesplazo extends StatelessWidget {
  final int items;
  final Widget? Function(BuildContext, int) itemABuildear;
  BarraDesplazo({super.key, required this.items, required this.itemABuildear});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _controller,
      thickness: 7,
      radius: const Radius.circular(20),
      child: ListView.builder(
        controller: _controller,
        itemCount: items,
        itemBuilder: itemABuildear,
      ),
    );
  }
}
