// lib/views/user_profile.dart
import 'package:flutter/material.dart';
import 'package:practica_final/utils/favourites_manager.dart';
import 'package:practica_final/models/model_games.dart';
import 'detail_page.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Driver> favorites = FavoritesManager.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilotos favoritos'),
        backgroundColor: const Color.fromARGB(255, 45, 252, 148),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No hay pilotos favoritos.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final driver = favorites[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage(driver.imagePath)),
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
    );
  }
}
