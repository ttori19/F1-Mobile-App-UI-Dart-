import 'package:flutter/material.dart';
import 'package:practica_final/views/vista_principal.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  final _formKey = GlobalKey<FormState>(); //validar el formulario form
  //obtener el texto escrito por el usuario
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //imagen como si fuera un appbar
          Container(
            height: 95,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/fondo_f1_4.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false, 
              child: Column(
                children: [
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
                    /*
                    con form podemos validar varios campos a la vez como si fuera un formulario
                    y con el inputfield se consigue no repetir codigo al crear cada campo 
                    los validator validan la condicion de estar completos o con otros requisitos
                     */
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
                            },//si los campos son validados llama a la funcion que la lleva a la siguiente pantalla
                            child: Container(
                              height: 45,
                              width: 150,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 9, 19, 75),
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
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
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
          ),
        ],
      ),
    );
  }

  /*
  funcion de ruta de acceso a la siguiente pantalla
  le pasa el mail para que podamos visualizarlo desde la vista del usuario
  */
  void vistaPrincipal(BuildContext context) {
    var route = MaterialPageRoute(
      builder: (context) => VistaPrincipal(email: _emailController.text), 
    );
    Navigator.of(context).push(route);
  }

  //crea un textformfield estilizado 
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
            Icon(icon, color: const Color.fromARGB(255, 9, 19, 75)),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
