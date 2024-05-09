import 'package:flutter/material.dart';
import 'home_listadoJuegos_page.dart';
import './servicios.dart'; 

class ListadoNotificacionesPage extends StatefulWidget {
  @override
  _ListadoNotificacionesPageState createState() => _ListadoNotificacionesPageState();
}

class _ListadoNotificacionesPageState extends State<ListadoNotificacionesPage> {
  final AceptarInvitacionServicio _invitacionAceptarServicio = AceptarInvitacionServicio();// Instancia de Servicios
  List<dynamic> invitaciones = [];
  List<dynamic> participantes = [];  ///// que envia el email de invitacion
  List<dynamic> juegos = [];         /////
  List<dynamic> jugadores = [];      /////

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await fetchInvitacion();
    await fetchGetParticipantes();  /////
    await fetchJugador();           /////
    await fetchGames();             /////
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
        title: Text("Notificaciones", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: ListView.builder(
        itemCount: invitaciones.length,
        itemBuilder: (BuildContext context, int index) {
          var invitacion = invitaciones[index];        ///
          var participante = participantes.firstWhere((participante) => participante['id'] == invitacion['participanteId'], orElse: () => null);
          var juego = juegos.firstWhere((juego) => juego['id'] == participante['juegoId'], orElse: () => null);
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
                 title: Text('Invitacion al juego "${juego != null ? juego['nombreJuego'] : 'Unknown'}" ', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(), // Línea divisoria entre el título y el contenido
                //Text('¡Bienvenido! ${invitaciones[index]['email']}'),
                 if (jugador != null)
                Text('${jugador['nombre']} te invito a unirte a su grupo de pasanku.'),
                if (juego != null)
                Text('que tendra un tiempo de duracion de ${juego['periodoRonda']}, con ${juego['cantidadJugadores']} paticipantes y un monto a pagar de ${juego['montoPago'].toString()} ${juego['moneda']}.'),
                SizedBox(height: 5),
                Text('fecha de Invitacion: ${invitaciones[index]['fechaHoraInvitacion'].toString()}'),  
                SizedBox(height: 5),

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
                         _aceptarJuego(juego['id']);  //_aceptar(jugador['id'], juego['id']);
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

  void _aceptarJuego(int juegoId,) {
    int estadoId= 5;     //estado habilitado
    int rolId= 2;        //rol de jugador
    var jugador = jugadores.firstWhere((jugador) => jugador['usuarioId'] == myIdUsuario, orElse: () => null);
    int jugadorIdActual = jugador != null ? jugador['id'] : null; //jugadorId del usuario actual

    _invitacionAceptarServicio.aceptarInvitacion(jugadorIdActual , juegoId, estadoId, rolId).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_)=>ListadoJuegosPage()));
    }).catchError((error) {
      print('Error: $error');
    });
  }
}