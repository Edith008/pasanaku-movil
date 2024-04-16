import 'package:flutter/material.dart';
import 'package:pasanaku_movil/pages/servicios.dart';
import 'listadoJuegos_page.dart';

class ListadoNotificacionesPage extends StatefulWidget {
  @override
  _ListadoNotificacionesPageState createState() => _ListadoNotificacionesPageState();
}

class _ListadoNotificacionesPageState extends State<ListadoNotificacionesPage> {
  List<dynamic> invitaciones = [];

  @override
  void initState() {
    super.initState();
    fetchInvitacion();
  }

  Future<void> fetchInvitacion() async {
    invitaciones = await InvitacionServicio.fetchInvitacion();
    setState(() {});
  }

  void eliminarNotificacion(int index) {
    setState(() {
      invitaciones.removeAt(index);
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
        itemCount: invitaciones.length,
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
                  title: Text('Hola ${invitaciones[index]['email']}'),
                ),
                Divider(), // Línea divisoria 
                //Text('Creador: ${notificaciones[index]['estado']}'),
                //Text('Monto: ${notificaciones[index]['estado']}'),
                Text('Descripcion: ${invitaciones[index]['descripcion']}'),
                Text('fecha de Expiracion: ${invitaciones[index]['fechaExpiracion']}'),
                Text('Duracion: ${invitaciones[index]['estado']}'),
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
}
