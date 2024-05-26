//aqui dejo el perfil de momento :V


import 'package:agenda_compumovil/Pages/Welcome.dart';
import 'package:agenda_compumovil/Services/Firebase.dart';
import 'package:agenda_compumovil/atajos/Barra.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      
appBar: const MiBarra(titulo: "Perfil =w="),


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