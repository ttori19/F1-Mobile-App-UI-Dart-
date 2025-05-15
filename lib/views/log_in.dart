import 'package:flutter/material.dart';
import 'package:practica_final/views/vista_principal.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(1, 1, 1, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "LOG IN",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.settings, size: 40),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(43, 0, 0, 0),
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                children: [
                  _inputField(Icons.mail_outline, "Email"),
                  const SizedBox(height: 20),
                  _inputField(Icons.lock_outline, "Password"),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => vistaPrincipal(context),
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 45, 252, 148),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(43, 0, 0, 0),
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "LOG IN",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void vistaPrincipal(BuildContext context) {
    var route = MaterialPageRoute(
      builder: (context) => VistaPrincipal(),
    );
    Navigator.of(context).push(route);
  }

  Widget _inputField(IconData icon, String hintText) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 45, 252, 148)),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
