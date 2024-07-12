import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Widget/Barra.dart';
import '../Widget/menu_lateral.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class PagCalendario extends StatefulWidget {
  const PagCalendario({Key? key}) : super(key: key);

  @override
  _PagCalendarioState createState() => _PagCalendarioState();
}

class _PagCalendarioState extends State<PagCalendario> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

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
          title: Text('Agregar Evento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  titulo = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descripción'),
                onChanged: (value) {
                  descripcion = value;
                },
              ),
            ],
          ),
          actions: [
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
              child: Text('Guardar'),
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
      appBar: MiBarra(titulo: "Calendario"),
      drawer: const MenuLateral(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              locale: "en_US",
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 4, 16),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
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
              eventLoader: (day) {
                return eventos[day] ?? [];
              },
            ),
            const SizedBox(height: 20),
            // Lista de eventos para el día seleccionado
            if (eventos[_selectedDay] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: eventos[_selectedDay]!.map((evento) {
                  return ListTile(
                    title: Text(evento.titulo),
                    subtitle: Text(evento.descripcion),
                  );
                }).toList(),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _addEvento,
                child: const Text('Agregar Evento'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
