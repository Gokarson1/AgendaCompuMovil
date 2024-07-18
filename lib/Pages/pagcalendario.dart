// lib/pages/pag_calendario.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Widget/Barra.dart';
import '../Widget/menu_lateral.dart';
import 'package:provider/provider.dart';
import '../providers/evento_provider.dart';
import '../models/evento.dart';

class PagCalendario extends StatefulWidget {
  const PagCalendario({Key? key}) : super(key: key);

  @override
  _PagCalendarioState createState() => _PagCalendarioState();
}

class _PagCalendarioState extends State<PagCalendario> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void _addEvento() {
    showDialog(
      context: context,
      builder: (context) {
        String titulo = '';
        String descripcion = '';

        return AlertDialog(
          title: const Text('Agregar Evento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  titulo = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                onChanged: (value) {
                  descripcion = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (titulo.isNotEmpty && descripcion.isNotEmpty) {
                  Provider.of<EventoProvider>(context, listen: false).addEvento(
                    Evento(
                      titulo: titulo,
                      descripcion: descripcion,
                      fecha: _selectedDay,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventos = Provider.of<EventoProvider>(context).eventos;

    return Scaffold(
      appBar: const MiBarra(titulo: "Calendario"),
      drawer: const MenuLateral(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TableCalendar(
                locale: "en_US",
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 4, 16),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) =>
                    DateTime.utc(day.year, day.month, day.day) ==
                    DateTime.utc(_selectedDay.year, _selectedDay.month,
                        _selectedDay.day),
                calendarFormat: _calendarFormat,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  todayTextStyle: const TextStyle(color: Colors.blue),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  defaultTextStyle: const TextStyle(color: Colors.black87),
                  weekendTextStyle: const TextStyle(color: Colors.black),
                ),
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                eventLoader: (day) {
                  return eventos[day] ?? [];
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedDay.isAtSameMomentAs(day)
                              ? Theme.of(context).primaryColor
                              : Colors.blue,
                        ),
                        width: 16.0,
                        height: 16.0,
                        child: Center(
                          child: Text(
                            '${events.length}',
                            style: const TextStyle().copyWith(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (eventos[_selectedDay] != null &&
                eventos[_selectedDay]!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: eventos[_selectedDay]!.map((evento) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(evento.titulo),
                      subtitle: Text(evento.descripcion),
                    ),
                  );
                }).toList(),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'No hay tareas en este día.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: _addEvento,
                  child: const Text('Agregar Evento'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
