import 'package:flutter/material.dart';
import 'package:practica_final/views/log_in.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'F1Stats',
        debugShowCheckedModeBanner: false,  // Oculta el banner que aparece en la esquina superior derecha
        home:  LogIn(), // Widget principal de main_view.dart
      );
}
