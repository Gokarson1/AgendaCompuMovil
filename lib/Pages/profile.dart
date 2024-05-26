//aqui dejo el perfil de momento :V


import 'package:agenda_compumovil/Pages/Welcome.dart';
import 'package:agenda_compumovil/Services/Firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        "Perfil =w=",
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
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
      Text("${FirebaseAuth.instance.currentUser!.displayName}"),
      Text("${FirebaseAuth.instance.currentUser!.email}"),
      ElevatedButton(
        onPressed: ()async{
        await FirebaseServices().signOut();
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=> const Home()));
      
      },
      child: const Text("Logout"),
        ),
    ],
  ),

  ),
      
    
    );
  }
}