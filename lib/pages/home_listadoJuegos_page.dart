import 'package:flutter/material.dart';
import 'package:pasanaku_movil/pages/servicios.dart';
import 'detalleJuego_page.dart'; 
import'listadoNotificaciones_page.dart';


class ListadoJuegosPage extends StatefulWidget {

  @override
  _ListadoJuegosPageState createState() => _ListadoJuegosPageState();
}

class _ListadoJuegosPageState extends State<ListadoJuegosPage> {
  List<dynamic> juegos = [];
  List<dynamic> juegosFiltrados = []; // Lista de juegos filtrados

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  Future<void> fetchGames() async {
    //juegos = await JuegoServicio.fetchGames();
    // Inicializar la lista de juegos filtrados con todos los juegos al principio
    if(acepteJuego == true){
      juegos = await JuegoServicio.fetchGames();
      juegosFiltrados = List.from(juegos);
    setState(() {});
    }
  }

  // Función para filtrar los juegos por nombre
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home: Lista de Juegos", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ListadoNotificacionesPage())); 
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
                filterJuegos(value);     // Filtrar los juegos cada vez que cambia el texto en el campo de búsqueda
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleJuegoPage(juego: juegosFiltrados[index]),));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                          Text('Rondas: ${juegosFiltrados[index]['periodoRonda']}'),
                        ],
                      ),
                      leading: CircleAvatar(
                        child: Image.asset('assets/images/grupo.png', height: 200),
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