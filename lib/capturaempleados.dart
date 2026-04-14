import 'package:flutter/material.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleadosScreen extends StatefulWidget {
  const CapturaEmpleadosScreen({super.key});

  @override
  State<CapturaEmpleadosScreen> createState() => _CapturaEmpleadosScreenState();
}

class _CapturaEmpleadosScreenState extends State<CapturaEmpleadosScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();

  void _guardarDatos() {
    if (_formKey.currentState!.validate()) {
      final String nombre = _nombreController.text;
      final String puesto = _puestoController.text;
      final double salario = double.tryParse(_salarioController.text) ?? 0.0;

      GuardarDatosDiccionario.registrarEmpleado(nombre, puesto, salario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Empleado guardado exitosamente', style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.blue.shade900,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _puestoController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Capturar Empleado'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Registro de Personal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: _nombreController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Nombre Completo',
                    labelStyle: TextStyle(color: Colors.blue.shade900),
                    prefixIcon: Icon(Icons.person, color: Colors.blue.shade900),
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    filled: true,
                    fillColor: Colors.lightBlue.shade50,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: _puestoController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Puesto',
                    labelStyle: TextStyle(color: Colors.blue.shade900),
                    prefixIcon: Icon(Icons.work, color: Colors.blue.shade900),
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    filled: true,
                    fillColor: Colors.lightBlue.shade50,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el puesto';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: _salarioController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Salario',
                    labelStyle: TextStyle(color: Colors.blue.shade900),
                    prefixIcon: Icon(Icons.attach_money, color: Colors.blue.shade900),
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    filled: true,
                    fillColor: Colors.lightBlue.shade50,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el salario';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Ingrese un número válido';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _guardarDatos,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.lightBlue.shade50,
                  foregroundColor: Colors.black,
                  shadowColor: Colors.blue,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.blue.shade900, width: 2),
                  ),
                ),
                child: const Text('Guardar Datos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
