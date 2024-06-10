import 'package:flutter/material.dart';

class MiFondo extends StatelessWidget {
  final Widget child;

  const MiFondo({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Image.asset("assets/images/fondo.jpg") 
          ]
        )
      

    );
  }
}
