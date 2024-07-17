import 'package:flutter/material.dart';
import '../Widget/menu_lateral.dart';
import '../Widget/Barra.dart';
import 'package:provider/provider.dart';
import '../main.dart'; // Asegúrate de que este import es correcto

class PagTarea extends StatelessWidget {
  const PagTarea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventos = Provider.of<EventoProvider>(context).eventos;

    List<Evento> eventosPendientes = [];
    List<Evento> eventosCompletados = [];

    eventos.forEach((key, value) {
      for (var evento in value) {
        if (!evento.completado) {
          eventosPendientes.add(evento);
        } else {
          eventosCompletados.add(evento);
        }
      }
    });

    return Scaffold(
      appBar: const MiBarra(titulo: "Tareas"),
      drawer: const MenuLateral(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pendientes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              if (eventosPendientes.isNotEmpty)
                Column(
                  children: eventosPendientes.map((evento) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          evento.titulo,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${evento.descripcion}\nFecha: ${evento.fecha.day}/${evento.fecha.month}/${evento.fecha.year}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.check_circle),
                          onPressed: () {
                            Provider.of<EventoProvider>(context, listen: false)
                                .toggleCompletado(evento);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'No hay tareas pendientes.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Completadas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              if (eventosCompletados.isNotEmpty)
                Column(
                  children: eventosCompletados.map((evento) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          evento.titulo,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        subtitle: Text(
                          '${evento.descripcion}\nFecha: ${evento.fecha.day}/${evento.fecha.month}/${evento.fecha.year}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.check_circle),
                          onPressed: () {
                            Provider.of<EventoProvider>(context, listen: false)
                                .toggleCompletado(evento);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'No hay tareas completadas.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
