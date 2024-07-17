import 'package:agenda_compumovil/Pages/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class Evento {
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  bool completado; // Nuevo campo para indicar si está completado o no

  Evento({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    this.completado = false, // Valor por defecto es false (no completado)
  });
}

class EventoProvider with ChangeNotifier {
  final Map<DateTime, List<Evento>> _eventos = {};

  Map<DateTime, List<Evento>> get eventos => _eventos;

  void addEvento(Evento evento) {
    if (_eventos[evento.fecha] == null) {
      _eventos[evento.fecha] = [];
    }
    _eventos[evento.fecha]?.add(evento);
    notifyListeners();
  }

  void toggleCompletado(Evento evento) {
    evento.completado = !evento.completado;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventoProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}