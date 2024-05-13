import 'package:flutter/material.dart';
import './servicios.dart';
import 'detalleJuego_page.dart';
import 'listadoNotificaciones_page.dart';

class ListadoJuegosPage extends StatefulWidget {
  @override
  _ListadoJuegosPageState createState() => _ListadoJuegosPageState();
}

class _ListadoJuegosPageState extends State<ListadoJuegosPage> {
  List<dynamic> juegos = [];            // Lista de juegos
  List<dynamic> juegosFiltrados = [];   // Lista de juegos filtrados para el buscador
  List<dynamic> participantes = [];     /////
  List<dynamic> jugadores = [];         /////
  List<dynamic> estados = [];      /////
  TextEditingController _controller = TextEditingController();

  //bool esUsuarioActual = false ; 

  @override
  void initState() {
    super.initState();
    cargarDatos();
    //esUsuarioActual = usuarioactual();
  }

  Future<void> cargarDatos() async {
  await fetchGetParticipantes(); 
  await fetchJugador(); 
  await fetchGames(); 
  await fetchEstados(); 
  }

  Future<void> fetchGetParticipantes() async {   /////
    participantes = await ParticipantesGetServicio.fetchGetParticipante();
    setState(() {});
  }

  Future<void> fetchJugador() async {      /////
    jugadores = await JugadorGetServicio.fetchJugador();
    setState(() {});
  }

  Future<void> fetchEstados() async {      /////
    estados = await EstadoGetServicio.fetchEstado();
    setState(() {});
  }  

  // Función para filtrar los juegos por nombre para el buscador (search)
  void filterJuegos(String query) {
    setState(() {
      juegosFiltrados.clear();
      juegos.forEach((juego) {
        if (juego['nombreJuego'].toLowerCase().contains(query.toLowerCase())) {
          juegosFiltrados.add(juego);
        }
      });
    });
  }

  Future<void> fetchGames() async {    //funciona 
    juegos = await JuegoServicio.fetchGames();
    List<dynamic> filteredGames = [];
    Set<dynamic> addedGameIds = Set(); // Conjunto para rastrear los IDs de juegos agregados
    for (var jugador in jugadores) {  
     if ( myIdUsuario == jugador['usuarioId']) { 
        for (var participante in participantes) {
          for (var juego in juegos) {
            if (jugador['id'] == participante['jugadorId']) {
              if (participante['juegoId'] == juego['id']) {
                // Verificar si el juego ya ha sido agregado usando el conjunto
                if (!addedGameIds.contains(juego['id'])) {
                  filteredGames.add(juego);
                  addedGameIds.add(juego['id']); // Marcar el juego como agregado
                  //break; 
                }
              }
           }
         }
       }
      } 
    }  
    
    setState(() {
    this.juegos = filteredGames; 
    this.juegosFiltrados = List.from(filteredGames);
    });
  }

  String  nombreUsuarioActual() {
    for (var jugador in jugadores) {
      if (myIdUsuario == jugador['usuarioId']) {
        return jugador['nombre'];
      }
    }
    return "";
  }

  String estadoJuego() {
  for (var estado in estados) {
    for (var juego in juegos) {
      if (juego['estadoId'] == estado['id']) {
        return estado['nombre']; // Retorna el nombre del estado si se encuentra una coincidencia
      }
    }
  }
  return 'Estado no encontrado'; // Retorna un valor predeterminado si no se encuentra ninguna coincidencia
}
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hola, ${nombreUsuarioActual()}", style: TextStyle(color: Colors.white)),  //"Home: Lista de Juegos"
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ListadoNotificacionesPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                filterJuegos(value); // Filtrar los juegos cada vez que cambia el texto en el campo de búsqueda
              },
              decoration: InputDecoration(
                hintText: 'Buscar juegos por nombre...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: juegosFiltrados.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>DetalleJuegoPage(juego: juegosFiltrados[index]),));
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(juegosFiltrados[index]['nombreJuego']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Estado: ${juegosFiltrados[index]['estado']}'),
                          //Text('Estado: ${estadoJuego()}'),
                          Text(
                              'Rondas: ${juegosFiltrados[index]['periodoRonda']}'),
                        ],
                      ),
                      leading: CircleAvatar(
                        child:
                            Image.asset('assets/images/grupo.png', height: 200),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
