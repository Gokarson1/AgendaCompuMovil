import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/evento.dart';

class EventoProvider with ChangeNotifier {
  final Map<DateTime, List<Evento>> _eventos = {};

  Map<DateTime, List<Evento>> get eventos => _eventos;

  Future<void> cargarEventosDesdeMapa(Map<String, dynamic> eventosMap) async {
    _eventos.clear(); // Limpiar eventos existentes antes de cargar
    eventosMap.forEach((key, value) {
      final DateTime fecha = DateTime.parse(key);
      final List<Evento> eventosList = (value as List)
          .map((item) => Evento.fromJson(item))
          .toList();
      _eventos[fecha] = eventosList;
    });
    notifyListeners();
  }

  Future<void> cargarEventos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? eventosJson = prefs.getString('eventos');
    if (eventosJson != null) {
      final Map<String, dynamic> eventosMap = jsonDecode(eventosJson);
      await cargarEventosDesdeMapa(eventosMap);
    }
  }

  Future<void> guardarEventos() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> eventosMap = {};

    _eventos.forEach((key, value) {
      eventosMap[key.toIso8601String()] = value.map((e) => e.toJson()).toList();
    });

    await prefs.setString('eventos', json.encode(eventosMap));
  }

  void addEvento(Evento evento) {
    if (_eventos[evento.fecha] == null) {
      _eventos[evento.fecha] = [];
    }
    _eventos[evento.fecha]?.add(evento);
    guardarEventos(); // Guardar eventos después de agregar
    notifyListeners();
  }

  void eliminarEvento(Evento evento) {
    _eventos[evento.fecha]?.remove(evento);
    if (_eventos[evento.fecha]?.isEmpty ?? false) {
      _eventos.remove(evento.fecha);
    }
    guardarEventos(); // Guardar eventos después de eliminar
    notifyListeners();
  }

  void toggleCompletado(Evento evento) {
    evento.completado = !evento.completado;
    guardarEventos(); // Guardar eventos después de cambiar completado
    notifyListeners();
  }
}
