import 'package:flutter/material.dart';
import './servicios.dart';
//import 'ofertar_page.dart';
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
  List<dynamic> atributosJuego = [];   ///
  bool isLoading = true;

  
  final _formKey = GlobalKey<FormState>();
  String _monto = '';
  String _nroRonda = '1' ;


  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await fetchGetParticipantes(); 
    await fetchJugador(); 
    setState(() {
      isLoading = false;
      this.atributosJuego = List.from(widget.juego.keys);
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

  void showDialogOfertar(){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center( child: Text('Ofertar'),),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Esta oferta es para ronda Nro. $_nroRonda'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Monto'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa el monto';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _monto = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los widgets
                  Text(widget.juego['moneda'].toString()),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print('Monto: $_monto');
                Navigator.pop(context);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 47, 22, 159), ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
              ),
            ),
              child: Text('Enviar', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
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
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                        color: Color.fromARGB(255, 9, 127, 83), // Puedes cambiar el color del contenedor del título aquí
                                        width: double.infinity, // Esto hará que el contenedor se expanda para llenar el ancho disponible
                                        child: Text(
                                          'Participantes:',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                          textAlign: TextAlign.center, // Esto centrará el texto dentro del contenedor
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: participantesEnJuego.length,
                                          itemBuilder: (context, index) {
                                            final participante = participantesEnJuego[index];
                                            final jugador = listaJugadores.firstWhere((jug) => jug['id'] == participante['jugadorId'], orElse: () => null);
                                            final nombreJugador = jugador != null ? jugador['nombre'] : 'Jugador no encontrado';
                                            final numeroParticipante = index + 1;

                                            return Container(
                                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                              child: Text('$numeroParticipante. $nombreJugador'),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
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
                            //Navigator.push(context, MaterialPageRoute(builder: (_)=>OfertarPage())); 
                            showDialogOfertar();
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
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ListaPagosPage(juego: widget.juego))); 
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
