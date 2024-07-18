// lib/providers/evento_provider.dart

import 'dart:convert'; // Necesario para trabajar con JSON
import 'package:agenda_compumovil/models/evento.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences

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

  void eliminarEvento(Evento evento) {
    _eventos[evento.fecha]?.remove(evento);
    notifyListeners();
  }

  // Métodos para guardar y cargar eventos en SharedPreferences

  Future<void> _guardarEventos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('eventos', json.encode(_eventos));
  }
  
Future<void> _cargarEventos() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Eliminar datos antiguos antes de cargar nuevos
  await prefs.remove('eventos');

  String? eventosString = prefs.getString('eventos');
  
  if (eventosString != null) {
    Map<String, dynamic> eventosMap = json.decode(eventosString);
    _eventos.clear();
    eventosMap.forEach((key, value) {
      DateTime dateTimeKey = DateTime.parse(key);
      _eventos[dateTimeKey] = (value as List<dynamic>).map((e) => Evento.fromJson(e)).toList();
    });
    notifyListeners();
  }
}




  // Llamar _cargarEventos() en el constructor o método de inicialización según necesites
  EventoProvider() {
    _cargarEventos();
  }
}
