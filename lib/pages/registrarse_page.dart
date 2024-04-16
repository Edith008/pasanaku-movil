import 'package:flutter/material.dart';
import './servicios.dart'; 
import'listadoJuegos_page.dart';

class RegistrarsePage extends StatefulWidget {
  const RegistrarsePage({super.key});

  @override
  State<RegistrarsePage> createState() => _RegistrarsePageState();
}

class _RegistrarsePageState extends State<RegistrarsePage> {
  final UsuarioServicio _servicioUsuario = UsuarioServicio();// Instancia de Servicios

  // Métodos para controlar los valores de los TextFormField
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  TextEditingController _repetirContrasenaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contrasenaController.addListener(_validarContrasenas);
    _repetirContrasenaController.addListener(_validarContrasenas);
  }


  String _errorEmail = '';
  String _errorNombre = '';
  String _errorTelefono = '';
  String _errorNoCoincideContrasena = '';
  String _errorLogContrasena = '';
  String _errorLogRepetirContrasena = '';

  bool _sonContrasenasValidas = false;
  bool _sonTelefonosValidos = false;
  bool _sonEmailValidos = false;
  bool _sonNombresValidos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: Text(
          "Regístrate en Pasanaku",
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 251, 251, 251)),
      ),
      body: Stack(
        children: <Widget>[
          // Fondo-registro-------------
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
              padding: const EdgeInsets.symmetric(vertical: 0.0), // Margen vertical
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 222, 225), 
                    borderRadius: BorderRadius.circular(10.0), 
                  ),
                  child: Form(
                    // logo --------------------------------------------
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0), // margen del logo
                            child: ClipRRect(
                              
                              borderRadius: BorderRadius.circular(50), 
                              child: Image.asset('assets/images/logo.png', height: 90),
                            ),
                          ), 
                          SizedBox(height: 20), 
                          //-------------------------------------------

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
                          //SizedBox(height: 10), 

                          TextFormField(
                            controller: _nombreController,
                            onChanged: (value) {
                              _validarNombre();
                            },
                            style: TextStyle(fontSize: 16), 
                            decoration: InputDecoration(
                              hintText: 'Nombre', 
                              hintStyle: TextStyle(color: Color.fromARGB(247, 127, 127, 127)),
                              prefixIcon: Icon(Icons.person), 
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), 
                            ),
                          ),
                          Text(_errorNombre,style: TextStyle(color: Colors.red)),
                          //SizedBox(height: 10), 

                          TextFormField(
                            controller: _telefonoController,
                            onChanged: (value) {
                              _validarLongitudTelefono();
                            },
                            style: TextStyle(fontSize: 16), 
                            decoration: InputDecoration(
                              hintText: 'Teléfono', 
                              hintStyle: TextStyle(color: Color.fromARGB(247, 127, 127, 127)),
                              prefixIcon: Icon(Icons.phone), 
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), 
                            ),
                          ),
                          Text(_errorTelefono,style: TextStyle(color: Colors.red)),
                          //SizedBox(height: 10), 

                          TextFormField(
                            controller: _contrasenaController,
                            onChanged: (value) {
                              _validarLongitudContrasena();
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
                          Text(_errorLogContrasena, style: TextStyle(color: Colors.red)),
                          //SizedBox(height: 10), 

                          TextFormField(
                            controller: _repetirContrasenaController,
                            onChanged: (value) {
                              _validarLongitudRepetirContrasena();
                            },
                            style: TextStyle(fontSize: 16), 
                            obscureText: true, 
                            decoration: InputDecoration(
                              hintText: 'Repite tu Contraseña', 
                              hintStyle: TextStyle(color: Color.fromARGB(247, 127, 127, 127)),
                              prefixIcon: Icon(Icons.lock), 
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), 
                            ),
                          ),
                          Text( _errorLogRepetirContrasena, style: TextStyle(color: Colors.red)),
                          Text( _errorNoCoincideContrasena, style: TextStyle(color: Colors.red)),
                          //SizedBox(height: 10),
                          
                          Center(
                            child: Text(
                              'Al hacer clic en Registrarme, acepta nuestros Términos de servicio y Política de privacidad',
                              textAlign: TextAlign.center, 
                              style: TextStyle(
                                fontSize: 10.0, 
                                fontWeight: FontWeight.normal, 
                                color: Color.fromARGB(247, 127, 127, 127),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        
                          SizedBox(
                            width: double.maxFinite, 
                            child: ElevatedButton(
                              onPressed: () {
                                 _registrarUsuario();       // Llama al metodo para registrar usuario
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 47, 22, 159),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Registrarme'),
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
  // Método para validar el correo electrónico-----------------------------------------
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
      _sonEmailValidos = isValidEmail; 
    });
  }

  // validar el correo electrónico-----------------------------------------
  void _validarNombre() {
    String nombre = _nombreController.text;
    setState(() {
      if (nombre.isEmpty) {
        _errorNombre = 'El campo no puede estar vacío.';
      } else {
          _errorNombre = '';
      }
      _sonNombresValidos = (nombre.isNotEmpty);
    });
  }

  // validar la longitud de la contraseña--------------------------------------
  void _validarLongitudTelefono() {
    String telefono = _telefonoController.text;
    setState(() {
      if ( telefono.isEmpty ) {
        _errorTelefono = 'El campo no puede estar vacío.';
      } else if (telefono.length != 8) {
        _errorTelefono = 'El telefono debe tener 8 digitos.';
      } else {
        _errorTelefono = '';
      } 
      _sonTelefonosValidos = (telefono.length == 8); 
    });
  }

  // validar la longitud de la contraseña---------------------------------------
  void _validarLongitudContrasena() {
    if (_contrasenaController.text.length < 6 ) {
      setState(() {
        _errorLogContrasena = 'La contraseña debe tener mínimo 6 caracteres.';
      });
    } else {
      setState(() {
        _errorLogContrasena = '';
      });
    }
  }

  void _validarLongitudRepetirContrasena() {
    if (_repetirContrasenaController.text.length < 6 ) {
      setState(() {
        _errorLogRepetirContrasena = 'La contraseña debe tener mínimo 6 caracteres.';
      });
    } else {
      setState(() {
        _errorLogRepetirContrasena = '';
      });
    }
  }

  // Validar las contraseñas ---------------------------------------------------------
  void _validarContrasenas() {
    bool longitudValida = _contrasenaController.text.length >= 6;
    bool contrasenasIguales = _contrasenaController.text == _repetirContrasenaController.text;
    setState(() {
      if (!longitudValida) {
        _errorLogContrasena = 'La contraseña debe tener mínimo 6 caracteres.';
      } else {
        _errorLogContrasena = '';
      }

      if (_repetirContrasenaController.text.isNotEmpty && !contrasenasIguales) {
        _errorNoCoincideContrasena = 'Las contraseñas no coinciden';
      } else {
        _errorNoCoincideContrasena = '';
      }
      _sonContrasenasValidas = longitudValida && contrasenasIguales;
    });
  }

  // Método para registrar usuario -------------------------------------------------------
  void _registrarUsuario() {
  if (_sonContrasenasValidas && _sonTelefonosValidos && _sonEmailValidos && _sonNombresValidos) {
    String email = _emailController.text;
    String nombre = _nombreController.text;
    String telefono = _telefonoController.text;
    String contrasena = _contrasenaController.text;

    _servicioUsuario.registrarUsuario(email, nombre, telefono, contrasena).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ListadoJuegosPage()));
    }).catchError((error) {
      print('Error: $error');
    });
    } else {
      print('No se puede registrar el usuario, no cumplen con los requisitos.');
    }
  }

   

}

