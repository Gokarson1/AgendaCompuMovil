// lib/main.dart
import 'package:agenda_compumovil/Pages/pagcalendario.dart';
import 'package:agenda_compumovil/Pages/pagtarea.dart';
import 'package:flutter/material.dart';

class BarraInf extends StatefulWidget {
  const BarraInf({super.key});

  @override
  State<BarraInf> createState() => _BarraInfState();
}

class _BarraInfState extends State<BarraInf> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Pagtarea(),
    PagCalendario(),
    Text('Index 2: Horario'),
    Text('Index 3: Calculadora'),
  ];

  void _selectOption(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _selectOption,
      ),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Tareas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Horario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calculate),
          label: 'Calculadora',
        ),
      ],
      currentIndex: selectedIndex,
      unselectedItemColor: Color.fromRGBO(185, 221, 255, 1),
      selectedItemColor: Colors.blue,
      backgroundColor: Colors.black,
      onTap: onItemTapped,
    );
  }
}
