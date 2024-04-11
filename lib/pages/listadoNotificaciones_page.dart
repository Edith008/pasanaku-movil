import 'package:flutter/material.dart';
import 'package:pasanaku_movil/pages/servicios.dart';
import 'listadoJuegos_page.dart';

class ListadoNotificacionesPage extends StatefulWidget {
  @override
  _ListadoNotificacionesPageState createState() => _ListadoNotificacionesPageState();
}

class _ListadoNotificacionesPageState extends State<ListadoNotificacionesPage> {
  List<dynamic> notificaciones = [];

  @override
  void initState() {
    super.initState();
    fetchNotificacion();
  }

  Future<void> fetchNotificacion() async {
    notificaciones = await NotificacionServicio.fetchNotificacion();
    setState(() {});
  }

  void eliminarNotificacion(int index) {
    setState(() {
      notificaciones.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Notificaciones", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: ListView.builder(
        itemCount: notificaciones.length,
        itemBuilder: (BuildContext context, int index) {
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
                  title: Text('Hola ${notificaciones[index]['email']}'),
                ),
                Divider(), // Línea divisoria 
                //Text('Creador: ${notificaciones[index]['estado']}'),
                //Text('Monto: ${notificaciones[index]['estado']}'),
                Text('Descripcion: ${notificaciones[index]['descripcion']}'),
                Text('fecha de Expiracion: ${notificaciones[index]['fechaExpiracion']}'),
                Text('Duracion: ${notificaciones[index]['estado']}'),
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
                          //  lógica para aceptar la notificación
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ListadoJuegosPage())); //MODIFIQUE ESTO
                        },
                        child: Text('ACEPTAR', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 8), // Espacio entre los botones
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // lógica para rechazar la notificación
                          eliminarNotificacion(index);
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
}
