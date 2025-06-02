import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_final/views/log_in.dart';
import 'package:practica_final/models/model_games.dart';
import 'package:practica_final/views/detail_page.dart'; 
import 'package:practica_final/views/user_profile.dart';

class VistaPrincipal extends StatefulWidget{
  final String email;
  const VistaPrincipal({super.key, required this.email}); //recibe el email desde la pantalla de log in

  @override
  State<VistaPrincipal> createState() => _VistaPrincipalState();
}

class _VistaPrincipalState extends State<VistaPrincipal>{
  late Future<List<Driver>> _futureDrivers; //para cargar la lista desde JSON
  String _searchQuery = ''; //para mantener el texto de campo de busqueda

  @override //llama al metodo para cargar los pilotos
  void initState() {
    super.initState();
    _futureDrivers = loadDrivers();
  }
  /*
    carga los datos de forma asincrona y los decodifica para convertir cada 
    uno en un objeto driver
    */
  Future<List<Driver>> loadDrivers() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulación de carga
    final String jsonString = await rootBundle.loadString('assets/json/data.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => Driver.fromJson(item)).toList();
  }

  void _recargar() { //recarga de la lista
    setState(() {
      _futureDrivers = loadDrivers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [ //imagen como si fuera un appbar
          Container(
            height: 95,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/fondo_f1_4.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea( // SafeArea que protege los iconos dentro del container
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    ),
                    child: const Icon(Icons.logout, size: 40, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserProfile(email: widget.email), //le pasa a la vista del perfil de usuario el email que ha registrado 
                        ),
                      );
                    },
                    child: const Icon(Icons.settings, size: 40, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextField( //actualiza la busqueda a medida que se realiza la busqueda
                      decoration: const InputDecoration(
                        hintText: 'Buscar piloto...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    /*
                    muestra un loader mientras carga, informando en caso de un posible error y si todo sale bien 
                    filtra la lista en funcion de nombre o equipo
                    */
                    child: FutureBuilder<List<Driver>>( 
                      future: _futureDrivers,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Error al cargar los datos.'));
                        } else {
                          final drivers = snapshot.data!;
                          final filteredDrivers = drivers.where((driver) =>
                            driver.name.toLowerCase().contains(_searchQuery) ||
                            driver.team.toLowerCase().contains(_searchQuery)
                          ).toList();
                          /*
                          deslizar hacia bajo para recargar y listview crea las cards para 
                          la vista de en detailpage
                          */
                          return RefreshIndicator(
                            onRefresh: () async => _recargar(),
                            child: ListView.builder(
                              itemCount: filteredDrivers.length,
                              itemBuilder: (context, index) {
                                final driver = filteredDrivers[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  elevation: 4,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(10),
                                    leading: Hero(
                                      tag: 'driver_${driver.id}',
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(driver.imagePath),
                                        radius: 30,
                                      ),
                                    ),
                                    title: Text(driver.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    subtitle: Text("Equipo: ${driver.team} | #${driver.number}"),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetailPage(driver: driver),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
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