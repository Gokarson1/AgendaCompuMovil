import '../Widget/Barra.dart';
import 'package:flutter/material.dart';

class PagCalculadora extends StatefulWidget {
  const PagCalculadora({super.key});

  @override
  _PagCalculadoraState createState() => _PagCalculadoraState();
}

class _PagCalculadoraState extends State<PagCalculadora> {
  List<TextEditingController> notasControllers = [TextEditingController(), TextEditingController()];
  List<TextEditingController> porcentajesControllers = [TextEditingController(), TextEditingController()];

  double notaFinal = 0.0;

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
    setState(() {
      notasControllers.add(TextEditingController());
      porcentajesControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: const MiBarra(titulo: "calculadora"),

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