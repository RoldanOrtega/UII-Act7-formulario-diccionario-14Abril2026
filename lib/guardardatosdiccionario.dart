import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Id autoconsecutivo
  static int _siguienteId = 1;

  static void registrarEmpleado(String nombre, String puesto, double salario) {
    int id = _siguienteId++;
    Empleado nuevoEmpleado = Empleado(
      id: id,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );
    // Guardar en el diccionario
    datosempleado[id] = nuevoEmpleado;
  }
}
