import 'package:flutter/material.dart';
import 'package:practica_final/utils/favourites_manager.dart';
import 'package:practica_final/models/model_games.dart';
import 'detail_page.dart';

class UserProfile extends StatelessWidget {
  final String email; //recibe el email como parametro

  const UserProfile({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final List<Driver> favorites = FavoritesManager.favorites; //obtiene la lista de pilotos favoritos

    return Scaffold(
      body: Column(
        children: [
          // Header con color de fondo y texto blanco
          Container(
            height: 95,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: const Color.fromARGB(255, 9, 19, 75),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Vuelve a la pantalla anterior
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Perfil de usuario',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),


          // Contenido con margen horizontal igual a las otras vistas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mostrar email
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Usuario: $email",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Lista de favoritos
                    Expanded(
                      child: favorites.isEmpty
                          ? const Center(child: Text('No hay pilotos favoritos.'))
                          : ListView.builder(
                              itemCount: favorites.length,
                              itemBuilder: (context, index) {
                                final driver = favorites[index];
                                return ListTile( //construccion de la lista
                                  leading: CircleAvatar(
                                      backgroundImage: AssetImage(driver.imagePath)),
                                  title: Text(driver.name),
                                  subtitle: Text("Equipo: ${driver.team}"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailPage(driver: driver), 
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
