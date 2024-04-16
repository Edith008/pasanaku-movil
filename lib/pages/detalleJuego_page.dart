import 'package:flutter/material.dart';

class DetalleJuegoPage extends StatelessWidget {
  final Map<String, dynamic> juego;

  DetalleJuegoPage({required this.juego});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle del Juego", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Contenedor con los datos del juego y un contenedor vacío en la misma fila
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView(
                      shrinkWrap: true, // Para asegurarse de que ListView ocupe el espacio mínimo
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text('Nombre: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(juego['nombreJuego']),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text('Estado: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(juego['estado'].toString()),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text('Monto: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(juego['montoPago'].toString()),
                              Text(juego['moneda'].toString()),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text('Jugadores: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(juego['cantidadJugadores'].toString()),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text('Ronda: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(juego['periodoRonda']),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text('Creacion: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(juego['fechaInicio'].toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espacio entre los contenedores
                Expanded(
                  child: Container(
                    height: 300.0, // Altura fija para el contenedor
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Puedes cambiar el color para diferenciar los contenedores
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // Puedes agregar contenido aquí si lo deseas
                   child: ListView(
                      shrinkWrap: true, // Para asegurarse de que ListView ocupe el espacio mínimo
                      children: [
                         //////
                      ]
                   )
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Espacio entre los contenedores
                Expanded(
                  child: Container(
                    height: 200.0, // Altura fija para el contenedor
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Puedes cambiar el color para diferenciar los contenedores
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // Puedes agregar contenido aquí si lo deseas
                   child: ListView(
                      shrinkWrap: true, // Para asegurarse de que ListView ocupe el espacio mínimo
                      children: [
                              //////
                      ]
                   )
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
