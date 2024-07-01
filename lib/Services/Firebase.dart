import 'package:agenda_compumovil/Pages/Welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class FirebaseServices {

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  
  static final Logger _logger = Logger();

  /// Metodo para iniciar sesion con Google y Firebase
  /// Devuelve true si el inicio de sesion es exitoso y false en caso contrario
  Future<bool> signInWithGoogle() async {
    bool ok = false;
    try {
      _logger.i("Iniciando el proceso de inicio de sesión con Google...");
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        _logger.i("Cuenta de Google seleccionada: ${googleSignInAccount.email}");
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await _auth.signInWithCredential(authCredential);
        _logger.i("Inicio de sesión con Google y Firebase exitoso.");

        // Guardar información del usuario en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('idToken', googleSignInAuthentication.idToken ?? '');
        prefs.setString('email', googleSignInAccount.email);
        prefs.setString('name', googleSignInAccount.displayName ?? '');
        prefs.setString('image', googleSignInAccount.photoUrl ?? '');

        // Llamar al servicio REST para registrar el acceso a la aplicación
        // Aquí deberías agregar la llamada a tu servicio REST
        // RestService.access(googleSignInAuthentication.idToken);

        ok = true;
      } else {
        _logger.w("Inicio de sesión con Google cancelado por el usuario.");
      }
    } on FirebaseAuthException catch (e) {
      _logger.e("Error en el inicio de sesión con Google: ${e.message}");
    } catch (e) {
      _logger.e("Error inesperado: ${e.toString()}");
    }
    return ok;
  }

  /// cerrar sesion de Google y Firebase
  Future<void> signOut(BuildContext context) async {
    try {
      _logger.i("Cerrando sesión...");
      await _auth.signOut();
      await _googleSignIn.signOut();
      _logger.i("Cierre de sesión exitoso.");

      // Limpiar la información de autenticación de SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('idToken', '');
      prefs.setString('email', '');
      prefs.setString('name', '');
      prefs.setString('image', '');
// Navegar de vuelta a la página de inicio
      Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (_) => false, // Con false se elimina toda la pila de navegación existente
    );

    } catch (e) {
      _logger.e("Error en el cierre de sesión: ${e.toString()}");
    }
  }
}