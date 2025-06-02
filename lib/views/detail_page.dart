// lib/views/detail_page.dart
import 'package:flutter/material.dart';
import 'package:practica_final/models/model_games.dart';
import 'package:practica_final/utils/favourites_manager.dart';

class DetailPage extends StatefulWidget {
  final Driver driver; //recibe un driver como parametro(el seleccionado)

  const DetailPage({super.key, required this.driver});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isFav;

  @override //comprueba si esta en favoritos
  void initState() {
    super.initState();
    isFav = FavoritesManager.isFavorite(widget.driver);
  }

  void toggleFavorite() { //comprueba si esta en favoritos para eliminarlo o añadirlo
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
    final driver = widget.driver; //extrae el piloto de los parametros para un uso mas facil

    return Scaffold(
      body: Column(
        children: [
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
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    driver.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //contenido principal del piloto
          Expanded(
            child: SingleChildScrollView(
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
                    icon: AnimatedSwitcher( //efecto visual al pulsar el boton
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey<bool>(isFav), // Importante para que detecte cambios
                          ),
                        ),

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
                      backgroundColor: const Color.fromARGB(255, 9, 19, 75),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
