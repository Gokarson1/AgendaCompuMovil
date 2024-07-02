class Asignatura {
  final String nombre;
  final String dia;
  final String horaInicio; // Guardado en formato HH:mm
  final String horaFin; // Guardado en formato HH:mm
  final String profesor;
  final String sala;

  Asignatura({
    required this.nombre,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
    required this.profesor,
    required this.sala,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'dia': dia,
      'horaInicio': horaInicio,
      'horaFin': horaFin,
      'profesor': profesor,
      'sala': sala,
    };
  }

  factory Asignatura.fromJson(Map<String, dynamic> json) {
    return Asignatura(
      nombre: json['nombre'],
      dia: json['dia'],
      horaInicio: json['horaInicio'],
      horaFin: json['horaFin'],
      profesor: json['profesor'],
      sala: json['sala'],
    );
  }
}
