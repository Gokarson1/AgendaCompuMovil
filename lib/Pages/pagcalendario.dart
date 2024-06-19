import 'package:table_calendar/table_calendar.dart';
import '../Widget/Barra.dart';
import 'package:flutter/material.dart';
import '../Widget/menu_lateral.dart';

class PagCalendario extends StatefulWidget {
  const PagCalendario({super.key});

  @override
  _PagCalendarioState createState() => _PagCalendarioState();
}

class _PagCalendarioState extends State<PagCalendario> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusDay){
    setState(() {
      today = day;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MiBarra(titulo: "Calendario"),
      drawer: const MenuLateral(),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        TableCalendar(
          locale: "en_US",
          rowHeight: 43,
          headerStyle:
            const HeaderStyle (formatButtonVisible: false , titleCentered: true),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 4, 16),
          onDaySelected: _onDaySelected,
        ),
      ],
    );
  }
}
