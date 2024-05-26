import 'package:agenda_compumovil/Pages/profile.dart';
import 'package:agenda_compumovil/Services/Firebase.dart';
import 'package:agenda_compumovil/atajos/Barra.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: const MiBarra(titulo: "Bienvenido =w="),
            
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


}

