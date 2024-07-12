import 'package:flutter/material.dart';

class ColorInfo {
  final String nombre;
  final Color color;

  ColorInfo({
    required this.nombre,
    required this.color,
  });
}

class Colores {
  static List<ColorInfo> listaColores = [
    ColorInfo(nombre: "Rojo", color: const Color(0xFFFF0000)), // Rojo
    ColorInfo(nombre: "Naranjo", color: const Color(0xFFFFA500)), // Naranjo
    ColorInfo(nombre: "Amarillo", color: const Color(0xFFFFFF00)), // Amarillo
    ColorInfo(nombre: "Verde", color: const Color(0xFF00FF00)), // Verde
    ColorInfo(nombre: "Celeste", color: const Color(0xFF00FFFF)), // Celeste
    ColorInfo(nombre: "Azul", color: const Color(0xFF0000FF)), // Azul
    ColorInfo(nombre: "Morado", color: const Color(0xFF800080)), // Morado
    ColorInfo(nombre: "Rosa", color: const Color(0xFFFFC0CB)), // Rosa
  ];
}
