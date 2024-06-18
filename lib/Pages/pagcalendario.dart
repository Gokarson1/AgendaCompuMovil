import '../Widget/Barra.dart';
import 'package:flutter/material.dart';
import '../Widget/menu_lateral.dart';

class PagCalendario extends StatelessWidget {
  const PagCalendario({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MiBarra(titulo: "Calendario"),
      drawer: MenuLateral(),





    );
  }
}