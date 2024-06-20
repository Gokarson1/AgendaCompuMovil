import 'package:agenda_compumovil/Widget/Barra.dart';
import 'package:agenda_compumovil/Widget/menu_lateral.dart';
import 'package:flutter/material.dart';

class PagCalculadora extends StatefulWidget {
  const PagCalculadora({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PagCalculadoraState createState() => _PagCalculadoraState();
}

class _PagCalculadoraState extends State<PagCalculadora> {
  List<TextEditingController> notasControllers = [TextEditingController(), TextEditingController()];
  List<TextEditingController> porcentajesControllers = [TextEditingController(), TextEditingController()];

  double notaFinal = 0.0;
  final int limiteNotas = 10;

  void calcularNotaFinal() {
    double sumaNotas = 0.0;
    for (int i = 0; i < notasControllers.length; i++) {
      double nota = double.parse(notasControllers[i].text) / 100;
      double porcentaje = double.parse(porcentajesControllers[i].text) / 100;
      sumaNotas += nota * porcentaje;
    }

    setState(() {
      notaFinal = sumaNotas;
    });
  }

  void agregarNota() {
    if (notasControllers.length < limiteNotas) {
      setState(() {
        notasControllers.add(TextEditingController());
        porcentajesControllers.add(TextEditingController());
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Límite alcanzado'),
          content: Text('No se pueden agregar más de $limiteNotas notas.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  void eliminarNota(int index) {
    setState(() {
      notasControllers.removeAt(index);
      porcentajesControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MiBarra(titulo: "Calculadora"),
      drawer: const MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notasControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: notasControllers[index],
                          decoration: InputDecoration(labelText: 'Nota ${index + 1} (%)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: porcentajesControllers[index],
                          decoration: InputDecoration(labelText: 'Porcentaje Nota ${index + 1} (%)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => eliminarNota(index),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: agregarNota,
              child: const Text('+ Agregar Nota'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularNotaFinal,
              child: const Text('Calcular Nota Final'),
            ),
            const SizedBox(height: 20),
            Text('Nota Final: ${(notaFinal * 100).toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }
}