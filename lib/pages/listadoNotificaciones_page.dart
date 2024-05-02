import 'package:flutter/material.dart';
import 'package:pasanaku_movil/pages/servicios.dart';
import 'home_listadoJuegos_page.dart';
import './servicios.dart'; 

class ListadoNotificacionesPage extends StatefulWidget {
  @override
  _ListadoNotificacionesPageState createState() => _ListadoNotificacionesPageState();
}

class _ListadoNotificacionesPageState extends State<ListadoNotificacionesPage> {
  //final AceptarInvitacionServicio _invitacionServicio = AceptarInvitacionServicio();// Instancia de Servicios
  List<dynamic> invitaciones = [];
  List<dynamic> participantes = [];  /////
  List<dynamic> juegos = [];         /////
  List<dynamic> jugadores = [];      /////

  @override
  void initState() {
    super.initState();
    fetchInvitacion();
    fetchGetParticipantes(); /////
    fetchGames();            /////
    fetchJugador();          /////
  }

  Future<void> fetchInvitacion() async {
    invitaciones = await InvitacionServicio.fetchInvitacion();
    //Extraer el email de invitacion para realizar una comparacion con myEmail.
    invitaciones = invitaciones.where((invitacion) => invitacion['email'] == myEmail).toList();
    setState(() {});
  }

  Future<void> fetchGetParticipantes() async { /////
    participantes = await ParticipantesGetServicio.fetchGetParticipante();
    setState(() {});
  }

  Future<void> fetchGames() async { /////
    juegos = await JuegoServicio.fetchGames();
    setState(() {});
  }

  Future<void> fetchJugador() async { /////
    jugadores = await JugadorGetServicio.fetchJugador();
    setState(() {});
  }

  //temporalmente''''''''''''''''''''''''''
  void eliminarNotificacion(int index) {
    setState(() {
      invitaciones.removeAt(index);
    });
  }
  //'''''''''''''''''''''''''''''''''''''''

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Notificaciones", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: ListView.builder(
        itemCount: invitaciones.length,
        itemBuilder: (BuildContext context, int index) {
          var invitacion = invitaciones[index];        ///
          //var participante = participantes.where((participante) => participante['id'] == invitacion['participanteId']).first;
          //var juego = juegos.where((juego) => juego['id'] == participante['juegoId']).first;

          //var participante = participantes['id'] == invitacion['participanteId'] ? participantes : null;
          //var juego = juego['id'] == participante['juegoId'] ? juego : null;

          var participante = participantes.firstWhere((participante) => participante['id'] == invitacion['participanteId'], orElse: () => null);
          var juego = juegos.firstWhere((juego) => juego['id'] == participante['juegoId'], orElse: () => null);

          //var jugador = jugadores.firstWhere((jugador) => jugador['id'] == participante['jugadorId'], orElse: () => null);
          var jugador;
          if (participante != null) {
            jugador = jugadores.firstWhere((jugador) => jugador['id'] == participante['jugadorId'], orElse: () => null);
          }


          return Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Hola ${invitaciones[index]['email']}'),
                ),
                Divider(), // Línea divisoria entre el título y el contenido
                Text('Descripcion: ${invitaciones[index]['descripcion']}'),
                if (jugador != null)
                  Text('nombre del anfritrion del juego: ${jugador['nombre']}'),
                if (juego != null) ...[
                  Text('Juego: ${juego['nombreJuego']}'), 
                  Text('Duracion: ${juego['periodoRonda']}'),
                  Text('Cantidad de jugadores: ${juego['cantidadJugadores']}'),
                  Text('Monto a pagar: ${juego['montoPago'].toString()} ${juego['moneda']}'),
                ],

                Text('fecha de Invitacion: ${invitaciones[index]['fechaHoraInvitacion'].toString()}'),  
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          //lógica para aceptar la notificación
                         _aceptar();
                        },
                        child: Text('ACEPTAR', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 8), 
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                         // Aquí debería ir la lógica para mostrar el diálogo de confirmación
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmación'),
                                content: Text('¿Estás seguro de que quieres rechazar la invitacion?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      // Aquí debería ir la lógica para manejar la acción de rechazar la notificación
                                      eliminarNotificacion(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Aceptar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('RECHAZAR', style: TextStyle(color: Colors.white)),
                        
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

    void _aceptar() {
    // Llama al método aceptarInvitacion del servicio
    acepteJuego = true;
    Navigator.push(context, MaterialPageRoute(builder: (_)=>ListadoJuegosPage()));
  }

}