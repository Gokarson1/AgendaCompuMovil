import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agenda_compumovil/models/asignatura.dart';

class FormularioAgregarClase extends StatefulWidget {
  final List<String> dias;
  final void Function(Asignatura) onAgregarClase;

  const FormularioAgregarClase({
    super.key,
    required this.dias,
    required this.onAgregarClase,
  });

  @override
  _FormularioAgregarClaseState createState() => _FormularioAgregarClaseState();
}

class _FormularioAgregarClaseState extends State<FormularioAgregarClase> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _profesorController = TextEditingController();
  final _salaController = TextEditingController();
  String? _diaSeleccionado;
  String? _horaInicio;
  String? _horaFin;

  @override
  void dispose() {
    _nombreController.dispose();
    _profesorController.dispose();
    _salaController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarHoraInicio(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time != null) {
      setState(() {
        _horaInicio =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _seleccionarHoraFin(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time != null) {
      setState(() {
        _horaFin =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _horaInicio != null &&
        _horaFin != null &&
        _diaSeleccionado != null) {
      final nuevaClase = Asignatura(
        nombre: _nombreController.text,
        dia: _diaSeleccionado!,
        horaInicio: _horaInicio!,
        horaFin: _horaFin!,
        profesor: _profesorController.text,
        sala: _salaController.text,
      );
      widget.onAgregarClase(nuevaClase);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Clase'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de la Clase'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la clase';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _profesorController,
                decoration: const InputDecoration(labelText: 'Profesor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del profesor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salaController,
                decoration: const InputDecoration(labelText: 'Sala'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la sala';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Día'),
                items: widget.dias
                    .map((dia) => DropdownMenuItem<String>(
                          value: dia,
                          child: Text(dia),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _diaSeleccionado = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un día';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text("Hora de Inicio: "),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () => _seleccionarHoraInicio(context),
                    child: Text(_horaInicio ?? 'Seleccionar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text("Hora de Fin: "),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () => _seleccionarHoraFin(context),
                    child: Text(_horaFin ?? 'Seleccionar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
