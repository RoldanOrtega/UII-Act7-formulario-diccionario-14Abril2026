import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Gestión de Empleados Super Hello de Andrea Roldan (Ceo)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.business_center, size: 120, color: Colors.lightBlue),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/captura');
              },
              icon: const Icon(Icons.person_add, color: Colors.black),
              label: const Text('Capturar Empleados', style: TextStyle(fontSize: 18, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.lightBlue.shade50,
                foregroundColor: Colors.black,
                shadowColor: Colors.blue,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.blue.shade900, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/ver');
              },
              icon: const Icon(Icons.list_alt, color: Colors.black),
              label: const Text('Ver Empleados', style: TextStyle(fontSize: 18, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.lightBlue.shade50,
                foregroundColor: Colors.black,
                shadowColor: Colors.blue,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.blue.shade900, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
