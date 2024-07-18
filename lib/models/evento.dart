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

  static Evento fromJson(Map<String, dynamic> json) {
  return Evento(
    titulo: json['titulo'],
    descripcion: json['descripcion'],
    fecha: DateTime.parse(json['fecha']),
    completado: json['completado'] ?? false,
  );
}
}
