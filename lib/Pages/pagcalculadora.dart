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
  double sumaPorcentajes = 0.0;
  bool hayDatosIngresados = false;

  for (int i = 0; i < notasControllers.length; i++) {
    double nota = double.tryParse(notasControllers[i].text) ?? 0.0;
    double porcentaje = double.tryParse(porcentajesControllers[i].text) ?? 0.0;

    if (nota != 0.0 && porcentaje != 0.0) {
      hayDatosIngresados = true;
      sumaNotas += (nota * porcentaje);
      sumaPorcentajes += porcentaje;
    }
  }

  // Calcular la nota final solo si hay datos ingresados válidos
  if (hayDatosIngresados && sumaPorcentajes > 0.0) {
    double notaFinalCalculada = sumaNotas / sumaPorcentajes;
    setState(() {
      notaFinal = notaFinalCalculada / 100; // Convertir a porcentaje
    });
  } else {
    setState(() {
      notaFinal = 0.0; // Si no hay datos válidos, asignar nota final como 0.0
    });
  }
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Ejemplo: Nota: 65           40%',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
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
        GestureDetector(
  onTap: agregarNota, // Función que se ejecuta al hacer tap en el contenedor
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey), // Borde gris
      borderRadius: BorderRadius.circular(5.0), // Bordes redondeados
    ),
    padding: const EdgeInsets.all(8.0), // Padding dentro del contenedor
    child: const Center(
      child: Text(
        '+ Agregar Nota',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Color del texto
        ),
      ),
    ),
  ),
),
const SizedBox(height: 5),
GestureDetector(
  onTap: calcularNotaFinal, // Función que se ejecuta al hacer tap en el contenedor
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey), // Borde gris
      borderRadius: BorderRadius.circular(5.0), // Bordes redondeados
    ),
    padding: const EdgeInsets.all(8.0), // Padding dentro del contenedor
    child: const Center(
      child: Text(
        'Calcular Nota Final',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Color del texto
        ),
      ),
    ),
  ),
),
const SizedBox(height: 5),

        Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), // Borde gris
    borderRadius: BorderRadius.circular(5.0), // Bordes redondeados
  ),
  padding: const EdgeInsets.all(8.0), // Padding dentro del contenedor
  child: Center(
    child: Text(
      'Nota Final: ${(notaFinal * 100).toStringAsFixed(2)}%',
      textAlign: TextAlign.center, // Alineación centrada del texto
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)
      ],
    ),
  ),
);

  }
}