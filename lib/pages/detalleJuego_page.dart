import 'package:flutter/material.dart';
import './servicios.dart';
import 'ofertar_page.dart';
import 'listaPagos_page.dart';

class DetalleJuegoPage extends StatefulWidget {
  final Map<String, dynamic> juego;       
  DetalleJuegoPage({required this.juego});
  
  @override
  _DetalleJuegoPageState createState() => _DetalleJuegoPageState();
}  

class _DetalleJuegoPageState extends State<DetalleJuegoPage> {
  List<dynamic> listaParticipantes = [];
  List<dynamic> listaJugadores = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGetParticipantes();
    fetchJugador();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await fetchGetParticipantes(); 
    await fetchJugador(); 
    setState(() {
      isLoading = false;
    });
  }


  Future<void> fetchGetParticipantes() async {   
    listaParticipantes = await ParticipantesGetServicio.fetchGetParticipante();
    setState(() {});
    // print('Participantes cargados: $listaParticipantes');
  }

  Future<void> fetchJugador() async {      
    listaJugadores= await JugadorGetServicio.fetchJugador();
    setState(() {});
    // print('Jugadores cargados: $listaJugadores');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.juego['nombreJuego'], style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                   color: Colors.grey[200],
                  //color: Color.fromARGB(255, 122, 179, 136),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text('LISTADO DE TURNOS O RONDAS', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                    children: [
                      Text('nro de turno y ganador'),
                    ],
                    ),
                  ],
                )  
              ),
            ),

            SizedBox(width: 10), 
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text('Monto a pagar por participante: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(widget.juego['moneda'].toString()),
                      SizedBox(width: 5),
                      Text(widget.juego['montoPago'].toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Nro de participantes: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(widget.juego['cantidadJugadores'].toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Monto total a recibir: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(widget.juego['moneda'].toString()),
                      SizedBox(width: 5),
                      Text((widget.juego['montoPago'] * widget.juego['cantidadJugadores']).toString()),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                final participantesEnJuego = listaParticipantes.where((participante) => participante['juegoId'] == widget.juego['id']).toList();
                                return Container(
                                  height: 600,
                                  child: ListView.builder(
                                    itemCount: participantesEnJuego.length,
                                    itemBuilder: (context, index) {
                                      final participante = participantesEnJuego[index];
                                      final jugador = listaJugadores.firstWhere((jug) => jug['id'] == participante['jugadorId'], orElse: () => null);
                                      final nombreJugador = jugador != null ? jugador['nombre'] : 'Jugador no encontrado';

                                      return ListTile(
                                        title: Text(nombreJugador),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Participantes', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 10), 
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>OfertarPage())); 
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade700, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Ofertar', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ListaPagosPage())); 
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 47, 22, 159), 
                      shape: RoundedRectangleBorder( 
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Lista de pagos', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
