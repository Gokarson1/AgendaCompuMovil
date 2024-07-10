import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BackendService {
  static final Logger _logger = Logger();

  /// Función para registrar/verificar un usuario en el backend
  static Future<void> registerUser(String name, String email) async {
   // _logger.i("email: $email");

    try {
      final response = await http.post(
        Uri.parse('http://192.168.50.150:3002/register'),
       headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['message'] == 'User already exists') {
          _logger.i('User already exists');
        } else {
          _logger.i('User registered: ${responseBody['id']}');
        }
      } else {
        _logger.e('Failed to register user');
      }
    } catch (e) {
      _logger.e("Error en el registro del usuario: ${e.toString()}");
    }
  }
}