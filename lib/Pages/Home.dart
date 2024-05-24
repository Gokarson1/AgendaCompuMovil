import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      backgroundColor: const Color(0xFF232F4B),
        title: const Text("Bienvenido =w="),
      ),
    body: const Center(child: Text ("Sexo"),)

    );
  }
}