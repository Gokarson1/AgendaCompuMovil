import 'package:flutter/material.dart';

class MiBarra extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final bool mostrarIconMenu;
  final TabBar? bottom; // Añadir la propiedad bottom

  const MiBarra({
    super.key,
    required this.titulo,
    this.mostrarIconMenu = true,
    this.bottom, // Añadir bottom al constructor
  });

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
      bottom: bottom, // Añadir bottom al AppBar
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? 80.0 : 120.0); // Ajusta la altura de la barra aquí
}
