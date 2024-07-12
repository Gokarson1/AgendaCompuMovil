// lib/providers/evento_provider.dart

import 'package:flutter/material.dart';

class Evento {
  final String titulo;
  final String descripcion;
  final DateTime fecha;

  Evento(
      {required this.titulo, required this.descripcion, required this.fecha});
}

class EventoProvider with ChangeNotifier {
  Map<DateTime, List<Evento>> _eventos = {};

  Map<DateTime, List<Evento>> get eventos => _eventos;

  void addEvento(Evento evento) {
    final fechaEvento =
        DateTime(evento.fecha.year, evento.fecha.month, evento.fecha.day);
    if (_eventos[fechaEvento] == null) {
      _eventos[fechaEvento] = [];
    }
    _eventos[fechaEvento]?.add(evento);
    notifyListeners();
  }
}
