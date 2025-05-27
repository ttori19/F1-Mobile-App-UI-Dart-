// lib/views/detail_page.dart
import 'package:flutter/material.dart';
import 'package:practica_final/models/model_games.dart';
import 'package:practica_final/utils/favourites_manager.dart';

class DetailPage extends StatefulWidget {
  final Driver driver;

  const DetailPage({super.key, required this.driver});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = FavoritesManager.isFavorite(widget.driver);
  }

  void toggleFavorite() {
    setState(() {
      if (isFav) {
        FavoritesManager.remove(widget.driver);
        isFav = false;
      } else {
        FavoritesManager.add(widget.driver);
        isFav = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFav
            ? 'Añadido a favoritos'
            : 'Eliminado de favoritos'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final driver = widget.driver;

    return Scaffold(
      appBar: AppBar(
        title: Text(driver.name),
        backgroundColor: const Color.fromARGB(255, 45, 252, 148),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'driver_${driver.id}',
              child: CircleAvatar(
                backgroundImage: AssetImage(driver.imagePath),
                radius: 80,
              ),
            ),
            const SizedBox(height: 20),
            Text(driver.name,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Equipo: ${driver.team}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            Text('Número: #${driver.number}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: toggleFavorite,
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              label: Text(isFav ? 'Eliminar de favoritos' : 'Añadir a favoritos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 192, 203),
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 45, 252, 148),
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
