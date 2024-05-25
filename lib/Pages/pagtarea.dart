import 'package:flutter/material.dart';

class Pagtarea extends StatelessWidget {
  const Pagtarea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: const Color(0xFF232F4B),
  title: Row(
    children: [
      Image.asset(
        'assets/images/logo.png',
        height: 50, // Ajusta la altura de la imagen según sea necesario
      ),
      const SizedBox(width: 10), // Añade un espacio entre la imagen y el texto
      const Text(
        "Tareas =w=",
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 40,
          color: Colors.white,
        ),
      ),
    ],
  ),
  toolbarHeight: 80.0,
),


      
    );
  }
}