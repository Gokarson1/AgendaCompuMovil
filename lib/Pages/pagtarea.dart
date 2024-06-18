import 'package:agenda_compumovil/Widget/menu_lateral.dart';

import '../Widget/Barra.dart';
import 'package:flutter/material.dart';

class PagTarea extends StatelessWidget {
  const PagTarea({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    appBar: MiBarra(titulo: "Tareas =w="),
      drawer: MenuLateral(),



      
    );
  }
}