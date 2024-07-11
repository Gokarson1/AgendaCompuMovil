// access_service.dart
import 'package:agenda_compumovil/models/auth.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AccessService {
  static const String _baseUrl = 'https://api.sebastian.cl/Auth';
  static const String _mime = 'application/json';
  static const Map<String, String> _headers = {
    'accept': _mime,
    'X-API-TOKEN': 'sebastian.cl',
    'X-API-KEY': 'aaa-bbb-ccc-ddd',
  };

  static final Logger _logger = Logger();
  static final Dio _client = Dio();

  static Future<List<AccessModel>> getAllAccesses(String email) async {
    try {
      const String url = '$_baseUrl/v1/access/all';

      _client.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ));

      Response response = await _client.get(url, 
        queryParameters: {'email': email}, // Aquí se añade el parámetro 'email'
        options: Options(headers: _headers));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data ?? [];
        List<AccessModel> accesses = data.map((json) => AccessModel.fromJson(json)).toList();
        return accesses;
      } else {
        _logger.e('Error al obtener los accesos: ${response.statusCode}');
        throw Exception('Error al obtener los accesos');
      }
    } catch (error) {
      _logger.e('Error inesperado: $error');
      throw Exception('Error inesperado al obtener los accesos');
    }
  }
}
