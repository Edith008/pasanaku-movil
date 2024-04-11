import 'package:flutter/material.dart';

class DetalleJuegoPage extends StatelessWidget {
  final Map<String, dynamic> juego;

  DetalleJuegoPage({required this.juego});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle del Juego",style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListView(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text('Nombre del juego: ', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Text('Cantidad de Jugadores: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(juego['cantidadJugadores'].toString()),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Text('Periodo de Ronda: ', style: TextStyle(fontWeight: FontWeight.bold)),
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
    );
  }
}
