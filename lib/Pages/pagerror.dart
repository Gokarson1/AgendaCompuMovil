import 'package:flutter/material.dart';

class PagError extends StatelessWidget {
  const PagError({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  backgroundColor: const Color(0xFF232F4B),
  title: const Row(
    children: [
      SizedBox(width: 10), // Añade un espacio entre la imagen y el texto
      Text(
        "Hubo un error :( ",
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
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 100, color: Colors.red),
            Text('Ha ocurrido un error',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}