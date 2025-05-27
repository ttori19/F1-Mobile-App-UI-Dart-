import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_final/views/log_in.dart';
import 'package:practica_final/models/model_games.dart';
import 'package:practica_final/views/detail_page.dart'; 
import 'package:practica_final/views/user_profile.dart';

class VistaPrincipal extends StatefulWidget{
  const VistaPrincipal({super.key});

  @override
  State<VistaPrincipal> createState() => _VistaPrincipalState();
}

class _VistaPrincipalState extends State<VistaPrincipal>{
  late Future<List<Driver>> _futureDrivers;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _futureDrivers = loadDrivers();
  }

  Future<List<Driver>> loadDrivers() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulación de carga
    final String jsonString = await rootBundle.loadString('assets/json/data.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => Driver.fromJson(item)).toList();
  }

  void _recargar() {
    setState(() {
      _futureDrivers = loadDrivers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 45, 252, 148),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  LogIn()),
                    ),
                    child: const Icon(Icons.logout, size: 40),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const UserProfile()),
                        );
                      },
                      child: const Icon(Icons.settings, size: 40),
                    ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
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

                    return RefreshIndicator(
                      onRefresh: () async {
                        _recargar();
                      },
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
    );
  }
}