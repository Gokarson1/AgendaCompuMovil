import 'package:flutter/material.dart';
import 'menu_lateral.dart';

class MiBarra extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final bool mostrarIconMenu;

  const MiBarra({super.key, required this.titulo, this.mostrarIconMenu = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF232F4B),
      toolbarHeight: 80.0,
      leading: mostrarIconMenu
          ? IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 35),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          : null,
      title: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              titulo,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      actions: [
        Image.asset(
          'assets/images/logo.png',
          height: 50,
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(80.0); // Ajusta la altura de la barra aquí
}
