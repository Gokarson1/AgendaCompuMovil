import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Evento {
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  bool completado;

  Evento({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    this.completado = false,
  });

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descripcion': descripcion,
    'fecha': fecha.toIso8601String(),
    'completado': completado,
  };

  static Evento fromJson(Map<String, dynamic> json) => Evento(
    titulo: json['titulo'],
    descripcion: json['descripcion'],
    fecha: DateTime.parse(json['fecha']),
    completado: json['completado'],
  );
}

class EventoProvider with ChangeNotifier {
  Map<DateTime, List<Evento>> _eventos = {};

  Map<DateTime, List<Evento>> get eventos => _eventos;

  EventoProvider() {
    _cargarEventos();
  }

  Future<void> _cargarEventos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? eventosJson = prefs.getString('eventos');
    if (eventosJson != null) {
      final Map<String, dynamic> decodedJson = jsonDecode(eventosJson);
      _eventos = decodedJson.map((key, value) {
        final List<Evento> eventosList = (value as List).map((item) => Evento.fromJson(item)).toList();
        return MapEntry(DateTime.parse(key), eventosList);
      });
      notifyListeners();
    }
  }

  Future<void> _guardarEventos() async {
    final prefs = await SharedPreferences.getInstance();
    final String eventosJson = jsonEncode(_eventos.map((key, value) {
      return MapEntry(key.toIso8601String(), value.map((item) => item.toJson()).toList());
    }));
    prefs.setString('eventos', eventosJson);
  }

  void addEvento(Evento evento) {
    final fechaEvento = DateTime(evento.fecha.year, evento.fecha.month, evento.fecha.day);
    if (_eventos[fechaEvento] == null) {
      _eventos[fechaEvento] = [];
    }
    _eventos[fechaEvento]?.add(evento);
    _guardarEventos();
    notifyListeners();
  }

  void toggleCompletado(Evento evento) {
    evento.completado = !evento.completado;
    _guardarEventos();
    notifyListeners();
  }
}
