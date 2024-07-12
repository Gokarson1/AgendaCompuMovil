import 'package:flutter/material.dart';
import '../Widget/menu_lateral.dart';
import '../Widget/Barra.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class PagTarea extends StatelessWidget {
  const PagTarea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventos = Provider.of<EventoProvider>(context).eventos;

    // Filtrar eventos pendientes y completados
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (eventosPendientes.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Pendientes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: eventosPendientes.length,
                      itemBuilder: (context, index) {
                        final evento = eventosPendientes[index];
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
                              icon: const Icon(Icons.check_circle_outline),
                              onPressed: () {
                                // Marcar como completado
                                Provider.of<EventoProvider>(context,
                                        listen: false)
                                    .toggleCompletado(evento);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              if (eventosCompletados.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Completadas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: eventosCompletados.length,
                      itemBuilder: (context, index) {
                        final evento = eventosCompletados[index];
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
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.check_circle),
                              onPressed: () {
                                // Marcar como no completado
                                Provider.of<EventoProvider>(context,
                                        listen: false)
                                    .toggleCompletado(evento);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
