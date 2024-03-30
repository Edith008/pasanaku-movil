import 'package:flutter/material.dart';


class RegistrarsePage extends StatefulWidget {
  const RegistrarsePage({super.key});

  @override
  State<RegistrarsePage> createState() => _RegistrarsePageState();
}

class _RegistrarsePageState extends State<RegistrarsePage> {
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
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Margen vertical
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 222, 225), 
                    borderRadius: BorderRadius.circular(20.0), 
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
                            style: TextStyle(fontSize: 16), 
                            decoration: InputDecoration(
                              hintText: 'Correo electrónico', 
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
                          SizedBox(height: 10), 
                          TextFormField(
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
                          SizedBox(height: 10), 
                          TextFormField(
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
                          SizedBox(height: 10), 
                          TextFormField(
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
                          SizedBox(height: 10), // Espacio adicional
                          TextFormField(
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
                          SizedBox(height: 10), 

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
                          
                          /*ElevatedButton(
                            onPressed: () {
                                    //
                            },
                            style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 47, 22, 159), 
                            onPrimary: Colors.white, 
                            shape: RoundedRectangleBorder( 
                            borderRadius: BorderRadius.circular(10),
                            ),
                            ),
                            child: Text('Registrarme'),
                          ),*/

                          SizedBox(
                            width: double.maxFinite, 
                            child: ElevatedButton(
                              onPressed: () {
                                // 
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
}

