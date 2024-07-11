import 'package:agenda_compumovil/Pages/accesos.dart';
import 'package:agenda_compumovil/Widget/barra_inf.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF232F4B),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Inicio'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BarraInf()),
              );
            },
          ),
          ListTile(
            title: const Text('Configuración'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              // Aquí puedes agregar la navegación para Configuración si es necesario
            },
          ),
          ListTile(
            title: const Text('Accesos'),
            leading: const Icon(Icons.lock_open),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AccessListScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
