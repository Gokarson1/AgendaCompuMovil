import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agenda_compumovil/Widget/formulario_agregar_clase.dart';
import 'package:agenda_compumovil/Widget/menu_lateral.dart';
import 'package:agenda_compumovil/models/asignatura.dart';
import '../Widget/Barra.dart';

class PagHorario extends StatefulWidget {
  const PagHorario({Key? key}) : super(key: key);

  @override
  _PagHorarioState createState() => _PagHorarioState();
}

class _PagHorarioState extends State<PagHorario> {
  List<String> dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  List<Asignatura> asignaturas = [];
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    _cargarAsignaturas();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

 Future<void> _cargarAsignaturas() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? asignaturasJson = prefs.getStringList('asignaturas');
  if (asignaturasJson != null) {
    setState(() {
      asignaturas = asignaturasJson
          .map((json) => Asignatura.fromJson(jsonDecode(json)))
          .toList();
      
      // Ordenar por hora de inicio
      asignaturas.sort((a, b) => a.horaInicio.compareTo(b.horaInicio));
    });
  }
}

  Future<void> _guardarAsignaturas() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> asignaturasJson = asignaturas
        .map((asignatura) => jsonEncode(asignatura.toJson()))
        .toList();
    prefs.setStringList('asignaturas', asignaturasJson);
  }

  void _agregarClase(Asignatura asignatura) {
  setState(() {
    asignaturas.add(asignatura);
    asignaturas.sort((a, b) => a.horaInicio.compareTo(b.horaInicio));
    _guardarAsignaturas();
  });
}

  void _eliminarClase(Asignatura asignatura) {
    setState(() {
      asignaturas.remove(asignatura);
      _guardarAsignaturas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MiBarra(
        titulo: "Horario",
      ),
      drawer: const MenuLateral(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                dias[_currentPageIndex],
                key: ValueKey<int>(_currentPageIndex),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: dias.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                List<Asignatura> clasesDelDia = asignaturas
                    .where((asignatura) => asignatura.dia == dias[index])
                    .toList();
                return clasesDelDia.isEmpty
                    ? const Center(
                        child: Text(
                          'Ninguna clase :P',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        itemCount: clasesDelDia.length,
                        itemBuilder: (context, index) {
                          final clase = clasesDelDia[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          clase.horaInicio,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          clase.horaFin,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              clase.nombre,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,  // Ajusta el tamaño del texto aquí
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${clase.profesor} - ${clase.sala}',
                                              style: const TextStyle(
                                                fontSize: 16,  // Ajusta el tamaño del texto aquí
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _eliminarClase(clase),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FormularioAgregarClase(
              dias: dias,
              onAgregarClase: _agregarClase,
            ),
          );
        },
      ),
    );
  }
}
