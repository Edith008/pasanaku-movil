import 'package:flutter/material.dart';
import'registrarse_page.dart';
import 'listadoJuegos_page.dart';
import './servicios.dart'; 

class IniciarsesionPage extends StatefulWidget {
  const IniciarsesionPage({super.key});

  @override
  State<IniciarsesionPage> createState() => _IniciarsesionPageState();
}

class _IniciarsesionPageState extends State<IniciarsesionPage> {
  final AuthUsuarioServicio _authUsuarioServicio = AuthUsuarioServicio();// Instancia de Servicios

  TextEditingController _emailController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();

  String _errorEmail = '';
  String _errorContrasena = '';

  bool _esEmailValido = false;
  bool _esContrasenaValido= false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: Text(
          "Pasanaku",
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: Stack(
        children: <Widget>[
          // Fondo-registro--------------------------
          /*Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo-registro.png'),
                fit: BoxFit.cover, 
              ),
            ),
          ),*/
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Margen vertical
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 222, 225), 
                    borderRadius: BorderRadius.circular(20.0), 
                  ),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0), 
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50), 
                              child: Image.asset('assets/images/logo.png', height: 90),
                            ),
                          ),
                          SizedBox(height: 20), 

                          TextFormField(
                            controller: _emailController,
                            onChanged: (value) {
                              _validarEmail();
                            },
                            style: TextStyle(fontSize: 16), 
                            decoration: InputDecoration(
                              hintText: 'pasanaku@gmail.com', 
                              hintStyle: TextStyle(color: Color.fromARGB(247, 127, 127, 127)),
                              prefixIcon: Icon(Icons.email), 
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Color.fromARGB(255, 27, 23, 129)), 
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), 
                            ),
                          ),
                          Text(_errorEmail,style: TextStyle(color: Colors.red)),
                          SizedBox(height: 10), 
                          
                          TextFormField(
                            controller: _contrasenaController,
                            onChanged: (value) {
                              _validarContrasena();
                            },
                            style: TextStyle(fontSize: 16), 
                            obscureText: true, 
                            decoration: InputDecoration(
                              hintText: 'Contraseña', 
                              hintStyle: TextStyle(color: Color.fromARGB(247, 127, 127, 127)),
                              prefixIcon: Icon(Icons.lock), 
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), 
                            ),
                          ),
                          Text(_errorContrasena,style: TextStyle(color: Colors.red)),
                          SizedBox(height: 10), 

                          SizedBox(
                            width: double.maxFinite, 
                            child: ElevatedButton(
                              onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (_)=>ListadoJuegosPage())); //MODIFIQUE ESTO
                                _iniciarSesion();
                                
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 47, 22, 159),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Iniciar Sesion'),
                            ),
                          ),
                          SizedBox(height: 10),

                          Center(
                            child: Text(
                              '¿olvidaste tu contraseña?',
                              textAlign: TextAlign.center, 
                              style: TextStyle(
                                fontSize: 10.0, 
                                fontWeight: FontWeight.normal, 
                                color: Color.fromARGB(247, 127, 127, 127),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>RegistrarsePage())); 
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 10.0, 
                                    fontWeight: FontWeight.normal, 
                                    color: Color.fromARGB(247, 127, 127, 127),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '¿No tienes una cuenta? ',
                                    ),
                                    TextSpan(
                                      text: 'Regístrate',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline, 
                                        color: Color.fromARGB(255, 47, 22, 159), 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );

  }



  // -----------------------------------------------------------------------------------
  // Método para validar el email-------------------------------------------------------
  void _validarEmail() {
    String email = _emailController.text;
    // Expresión regular para validar el correo electrónico
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    bool isValidEmail = regex.hasMatch(email);
    setState(() {
      if (email.isEmpty) {
        _errorEmail = 'El campo no puede estar vacío.';
      } else if (!isValidEmail) {
        _errorEmail = 'Por favor, introduce una dirección de correo electrónico válida.';
      } else {
          _errorEmail = '';
      }
      _esEmailValido = isValidEmail; 
    });
  }

  // Método para validar la contraseña--------------------------------------------------
  void _validarContrasena() {
    bool longitudValida = _contrasenaController.text.length >= 6;
    String contrasena = _contrasenaController.text;
    setState(() {
      if (!longitudValida) {
        _errorContrasena = 'La contraseña debe tener mínimo 6 caracteres.';
      } else {
        _errorContrasena = '';
      }
      _esContrasenaValido = longitudValida;
    });
  }

  // Método para auth usuario -------------------------------------------------------
  void _iniciarSesion() {
  if (_esEmailValido && _esContrasenaValido) {
    String email = _emailController.text;
    String contrasena = _contrasenaController.text;

    _authUsuarioServicio.authUsuario(email, contrasena).then((data) {
      if (data.containsKey('accessToken')) {
        print('Token JWT: ${data['accessToken']}');  // Imprime el token por consola
        //String userEmail = data['userEmail']; // Reemplaza 'userEmail' con el campo real en la respuesta del servidor
        //sprint('Correo electrónico del usuario: $userEmail');
        Navigator.push(context, MaterialPageRoute(builder: (_) => ListadoJuegosPage()));
      } else {
        print('No se recibió el token de autenticación');
        print(data['error']);
      }
    }).catchError((error) {
      print('Error: $error');
    });
  } else {
    print('No se puede autenticar el usuario con los datos proporcionados');
  }
}



}
