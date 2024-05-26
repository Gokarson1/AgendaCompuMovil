import 'package:flutter/material.dart';

class MiFondo extends StatelessWidget {
  final Widget child;

  const MiFondo({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fondo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Child widget
        child,
      ],
    );
  }
}
