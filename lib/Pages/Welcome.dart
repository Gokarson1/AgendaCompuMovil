import 'package:agenda_compumovil/Pages/profile.dart';
import 'package:agenda_compumovil/Services/Firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232F4B),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 50, // Ajusta la altura de la imagen según sea necesario
            ),
            const SizedBox(width: 10), // Añade un espacio entre la imagen y el texto
            const Text(
              "Bienvenido =w=",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
        toolbarHeight: 80.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: ElevatedButton(
            child: const Row(
              children: [Icon(Icons.g_mobiledata), Text('Login')],
            ),
            onPressed: () async{
              await FirebaseServices().signInWithGoogle();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Profile()));
            },
          ),
        ),
      ),
    );
  }


signInWithGoogle() async{



}


}

