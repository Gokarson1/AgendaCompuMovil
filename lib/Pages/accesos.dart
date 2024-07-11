// access_list_screen.dart
import 'package:agenda_compumovil/Widget/Barra.dart';
import 'package:agenda_compumovil/Widget/menu_lateral.dart';
import 'package:agenda_compumovil/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:agenda_compumovil/Services/access_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessListScreen extends StatefulWidget {
  @override
  _AccessListScreenState createState() => _AccessListScreenState();
}

class _AccessListScreenState extends State<AccessListScreen> {
  List<AccessModel> _accesses = [];
  bool _isLoading = true;
  String _errorMessage = '';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('email') ?? '';
    });
    _loadAccesses();
  }

  Future<void> _loadAccesses() async {
    try {
      List<AccessModel> accesses = await AccessService.getAllAccesses(_userEmail);
      setState(() {
        _accesses = accesses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar los accesos: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MiBarra(titulo: "Tareas =w="),
      drawer: const MenuLateral(),
     body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: _accesses.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            title: Text(
                              'Usuario: ${_accesses[index].email}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('User Agent: ${_accesses[index].userAgent}'),
                                Text('Fecha y Hora: ${_accesses[index].created}'),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                    Container(
                      height: 50,
                      color: const Color(0xFF232F4B),
          
                    ),
                  ],
                ),
    );
  }
}