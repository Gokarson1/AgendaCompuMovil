import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agenda_compumovil/Widget/formulario_agregar_clase.dart';
import 'package:agenda_compumovil/Widget/menu_lateral.dart';
import 'package:agenda_compumovil/models/asignatura.dart';
import '../Widget/Barra.dart';

class PagHorario extends StatefulWidget {
  const PagHorario({super.key});

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
    'Sábado'
  ];
  List<Asignatura> asignaturas = [];

  @override
  void initState() {
    super.initState();
    _cargarAsignaturas();
  }

  Future<void> _cargarAsignaturas() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? asignaturasJson = prefs.getStringList('asignaturas');
    if (asignaturasJson != null) {
      setState(() {
        asignaturas = asignaturasJson
            .map((json) => Asignatura.fromJson(jsonDecode(json)))
            .toList();
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
    return DefaultTabController(
      length: dias.length,
      child: Scaffold(
        appBar: MiBarra(
          titulo: "Horario",
          bottom: TabBar(
            tabs: dias.map((dia) => Tab(text: dia)).toList(),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        drawer: const MenuLateral(),
        body: TabBarView(
          children: dias.map((dia) {
            List<Asignatura> clasesDelDia = asignaturas
                .where((asignatura) => asignatura.dia == dia)
                .toList();
            return ListView.builder(
              itemCount: clasesDelDia.length,
              itemBuilder: (context, index) {
                final clase = clasesDelDia[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        clase.nombre,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${clase.profesor} - ${clase.sala}\n${clase.horaInicio} - ${clase.horaFin}',
                      ),
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.all(16.0),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _eliminarClase(clase),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
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
      ),
    );
  }
}
