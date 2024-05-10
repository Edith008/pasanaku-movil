import 'package:flutter/material.dart';
import'registrarse_page.dart';
import 'iniciarSesion_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Fondo-inicio-------------
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo-inicio.png'),
                fit: BoxFit.cover, 
              ),
            ),
          ),
          //--------------------------------
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              //para ajustar la imagen del logo -------------------
              child: SingleChildScrollView(    
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100), 
                    child: Image.asset('assets/images/logo.png', height: 200),
                  ),
                  SizedBox(height: 10.0), 
                  //--------------------------------------------------
                  Text(
                    'PASANAKU',
                    style: TextStyle(
                      fontFamily: 'LexendPeta', 
                      fontSize: 40.0, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 60.0),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 250),
                            onPrimary: Color.fromARGB(255, 33, 32, 32), 
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone), 
                              SizedBox(width: 5), 
                              Text('Ingresar con Teléfono'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // 
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 250),
                            onPrimary: Color.fromARGB(255, 33, 32, 32), 
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset('assets/images/g.png', height: 20),
                              ),
                              SizedBox(width: 5), 
                              Text('Ingresar con Google'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>RegistrarsePage())); 
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 47, 22, 159),
                            onPrimary: Colors.white, 
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Registrarse'),
                        ),
                      ),
                      SizedBox(width: 10), 
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>IniciarsesionPage())); 
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
                    ],
                  ),

                ],
              ),
              ),
              ),
            ),
        ],
      ),
    );
  }
}