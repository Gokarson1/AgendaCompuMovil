import 'package:flutter/material.dart';
import 'package:agenda_compumovil/Pages/accesos.dart';
import 'package:agenda_compumovil/Widget/barra_inf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agenda_compumovil/Services/Firebase.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 250, // Altura del DrawerHeader ajustada según necesidad
            decoration: const BoxDecoration(
              color: Color(0xFF232F4B),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : const AssetImage('assets/default_profile.png')
                              as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Espacio adicional entre la imagen y el texto
                Text(
                  user?.displayName ?? '', // Nombre del usuario
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto', // Fuente Roboto
                  ),
                ),
                const SizedBox(height: 5), // Espacio adicional entre la imagen y el texto
                Text(
                  user?.email ?? '', // Email del usuario
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto', // Fuente Roboto
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Márgenes internos al contenedor
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400), // Borde alrededor del contenedor
              borderRadius: BorderRadius.circular(5), // Bordes redondeados
            ),
            child: ListTile(
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
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Márgenes internos al contenedor
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400), // Borde alrededor del contenedor
              borderRadius: BorderRadius.circular(5), // Bordes redondeados
            ),
            child: ListTile(
              title: const Text('Configuración'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                // Aquí puedes agregar la navegación para Configuración si es necesario
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Márgenes internos al contenedor
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400), // Borde alrededor del contenedor
              borderRadius: BorderRadius.circular(5), // Bordes redondeados
            ),
            child: ListTile(
              title: const Text('Accesos'),
              leading: const Icon(Icons.lock_open),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccessListScreen()),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Márgenes internos al contenedor
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400), // Borde alrededor del contenedor
              borderRadius: BorderRadius.circular(5), // Bordes redondeados
            ),
            child: ListTile(
              title: const Text('Log Out'),
              leading: const Icon(Icons.logout_outlined),
              onTap: () async {
               await FirebaseServices().signOut(context);

              },
            ),
          ),
        ],
      ),
    );
  }
}

