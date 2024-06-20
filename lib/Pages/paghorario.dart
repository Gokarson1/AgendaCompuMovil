import 'package:agenda_compumovil/Widget/menu_lateral.dart';
import '../Widget/Barra.dart';
import 'package:flutter/material.dart';

class PagHorario extends StatelessWidget {
  const PagHorario({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MiBarra(titulo: "Horario"),
      drawer: MenuLateral(),




    );
  }
}