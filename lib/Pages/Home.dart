// ignore_for_file: file_names

import 'package:agenda_compumovil/Pages/pagerror.dart';
import 'package:agenda_compumovil/Pages/pagtarea.dart';
import 'package:agenda_compumovil/Services/google_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';


class Home extends StatelessWidget {
  static final _logger = Logger();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes:['email']);
  


   Home({super.key});

  // ignore: unused_element
  Future<bool> _autenticacion() async {
    bool auth =false;
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
  if (account!=null){
  GoogleSignInAuthentication authentication= await account.authentication;
  final String idToken = authentication.idToken ?? '';
  final String accessToken = authentication.accessToken ?? '';
  auth =idToken.isNotEmpty;
  _logger.d(idToken);
  _logger.d(accessToken);
}
    } catch (error,stackTrace){
      _logger.e('Error al inisair sesion :(: ${error.toString()})');
      _logger.d(stackTrace.toString(),stackTrace: stackTrace);
    }
    return auth;
  }

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
        children: [Icon(Icons.g_mobiledata), Text('Entrar con Google')],
      ),
      onPressed: () {
        GoogleService.logIn().then((result) {
          if (result) {
            _logger.i('Me pude autenticar');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Pagtarea();
            }));
          } else {
            _logger.e('No fue posible autenticar');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const PagError();
            }));
          }
        });
      },
    ),
  ),
),

    );
  }
}
