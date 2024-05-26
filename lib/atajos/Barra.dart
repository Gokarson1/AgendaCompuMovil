import 'package:flutter/material.dart';

class MiBarra extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const MiBarra({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF232F4B),
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 50, // Ajusta la altura de la imagen según sea necesario
          ),
          const SizedBox(width: 10), // Añade un espacio entre la imagen y el texto
          Text(
            titulo,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
      toolbarHeight: 80.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
