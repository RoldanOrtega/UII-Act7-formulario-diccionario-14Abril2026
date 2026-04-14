import 'package:flutter/material.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión BD Empleados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioScreen(),
        '/captura': (context) => const CapturaEmpleadosScreen(),
        '/ver': (context) => const VerEmpleadosScreen(),
      },
    );
  }
}
