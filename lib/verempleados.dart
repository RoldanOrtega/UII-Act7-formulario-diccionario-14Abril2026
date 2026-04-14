import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleadosScreen extends StatelessWidget {
  const VerEmpleadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final empleados = datosempleado.values.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Lista de Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.black,
      ),
      body: empleados.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off, size: 80, color: Colors.lightBlue),
                  SizedBox(height: 16),
                  Text(
                    'No hay empleados registrados.',
                    style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: empleados.length,
              itemBuilder: (context, index) {
                final empleado = empleados[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
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
                  child: Card(
                    color: Colors.lightBlue.shade50,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.blue.shade900, width: 2),
                    ),
                    elevation: 0, // Elevation handled by Container boxShadow
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade900,
                        radius: 25,
                        child: Text(
                          empleado.id.toString(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      title: Text(
                        empleado.nombre,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.work_outline, size: 16, color: Colors.blue.shade800),
                                const SizedBox(width: 5),
                                Text('Puesto: ${empleado.puesto}', style: TextStyle(color: Colors.blue.shade900)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.monetization_on_outlined, size: 16, color: Colors.blue.shade800),
                                const SizedBox(width: 5),
                                Text('Salario: \$${empleado.salario.toStringAsFixed(2)}', style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
