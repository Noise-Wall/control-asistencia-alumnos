import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class AnimCarga extends StatelessWidget {
  const AnimCarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        // decoration: BoxDecoration(
        //   color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        //         ? Colors.white
        //         : null,
        //   border: Border.all(color: Colors.indigo, width: 2.0),
        //   borderRadius: BorderRadius.circular(12),
        //   boxShadow: const [
        //     BoxShadow(
        //       color: Colors.black12,
        //       spreadRadius: 2,
        //       blurRadius: 2,
        //       offset: Offset(0, 2),
        //     )
        //   ],
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Cargando...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.indigo.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
