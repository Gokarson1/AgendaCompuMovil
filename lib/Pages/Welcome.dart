
import 'package:agenda_compumovil/Services/Firebase.dart';
import 'package:agenda_compumovil/Widget/Barra.dart';
import 'package:agenda_compumovil/Widget/barra_inf.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MiBarra(titulo: "Bienvenido =w=",
      mostrarIconMenu: false,),
            
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.jpg"),
            fit: BoxFit.cover,
          ),
        ),

            
      
      
       child: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: ElevatedButton(
            child: const Row(
              children: [Icon(Icons.g_mobiledata), Text('Login')],
            ),
            onPressed: () async{
              await FirebaseServices().signInWithGoogle();
              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const BarraInf()));
            },
          ),
        ),
      ),



    )
    );
  }


}

