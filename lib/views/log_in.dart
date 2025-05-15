import 'package:flutter/material.dart';
import 'package:practica_final/views/vista_principal.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                children: const [
                  Text("LOG IN",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  Icon(Icons.settings, size: 40),
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
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(43, 0, 0, 0),
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _inputField(
                      icon: Icons.mail_outline,
                      hintText: "Email",
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Introduce un email válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _inputField(
                      icon: Icons.lock_outline,
                      hintText: "Password",
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'La contraseña debe tener al menos 8 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          vistaPrincipal(context);
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 45, 252, 148),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(43, 0, 0, 0),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
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

  Widget _inputField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon:
            Icon(icon, color: const Color.fromARGB(255, 45, 252, 148)),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
