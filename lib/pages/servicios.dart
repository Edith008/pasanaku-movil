import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServicioBase {
  static const String baseUrl = 'http://127.0.0.1:4000';                    //para chrome
  //static const String baseUrl = 'http://10.0.2.2:4000';                     //para  emulador          
  //static const String baseUrl = 'https://0318-181-41-149-56.ngrok-free.app';  //para movil fisico
  //static const String baseUrl = 'http://192.168.0.9:4000';  
}

var myEmail = '';
var myIdUsuario = -1;
bool acepteJuego = false;

//obtener juegos----------------------------------------------------------------
class JuegoServicio {
  static Future<List<dynamic>> fetchGames() async {
    final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/juegos'));   
    if (response.statusCode == 200) {
      debugPrint("se cargaron juegos correctamente"); // Imprimir en consola
      //debugPrint(response.body);                    // Imprimir en consola
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los juegos');
    }
  }
}

//obtener invitaciones----------------------------------------------------------------
class InvitacionServicio {   //para listado de notificaciones
  static Future<List<dynamic>> fetchInvitacion() async {
    final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/invitaciones')); 
    if (response.statusCode == 200) {
      //debugPrint("se cargaron las invitaciones correctamente");
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar las invitaciones');
    }
  }
}

//Registar usuario----------------------------------------------------------------
class RegistroUsuarioServicio {   //para registro de usuario y jugador
  Future<void> registrarUsuario(String email, String nombre, String telefono, String contrasena) async {
    try {
      var url = Uri.parse('${ServicioBase.baseUrl}/usuarios/crear-usuario-jugador'); 
      var response = await http.post(
        url,
        body: {
          'email': email,
          'contrasena': contrasena,
          'telefono': telefono,
          'nombre': nombre,
        },
      );

      if (response.statusCode == 201) {
        print('Usuario registrado exitosamente: ${response.statusCode}');
      } else {
        print('Error al registrar usuario: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

//autenticar usuario----------------------------------------------------------------
class AuthUsuarioServicio {
  Future<Map<String, dynamic>> authUsuario(String email, String contrasena) async {
    try {
      //usar url de la api para dispositivos android fisico
      var url = Uri.parse('${ServicioBase.baseUrl}/auth/login');  
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'contrasena': contrasena,
        }),
      );
      
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        var token = data['accessToken'];    
        // print(token);
        //Extraer el usuarioId del token.
        var tokenSplit = token.split('.');
        var payload = json.decode(utf8.decode(base64.decode(base64.normalize(tokenSplit[1]))));
        myIdUsuario = int.parse(payload['usuarioId'].toString());
        print('usuarioId JWT: $myIdUsuario');
        return data; // Devuelve el Map con los datos de la respuesta

      } else {
        return {'error': 'Error al iniciar sesión: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }
}

//obtener participantes----------------------------------------------------------------
class ParticipantesGetServicio {  
  static Future<List<dynamic>> fetchGetParticipante() async {
    final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/participantes')); 
    if (response.statusCode == 200) {
      //debugPrint("se cargaron los paticipantes correctamente");
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los participantes');
    }
  }
}

//obtener jugador--------------------------------------------------------------------
class JugadorGetServicio {  
  static Future<List<dynamic>> fetchJugador() async {
    final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/jugadores')); 
    if (response.statusCode == 200) {
      //debugPrint("se cargaron los jugadores correctamente");
      //print(response.body);                    // Imprimir en consola
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los jugadores');
    }
  }
}

// crear participante----------------------------------------------------------------
class AceptarInvitacionServicio {
  Future<void> aceptarInvitacion(int jugadorId, int juegoId, int estadoId, int rolId) async {
    try { 
      var url = Uri.parse('${ServicioBase.baseUrl}/participantes'); 
        var response = await http.post(
          url,
          body: {
          'jugadorId': jugadorId.toString(),
          'juegoId': juegoId.toString(), 
          'estadoId': estadoId.toString(),
          'rolId': rolId.toString(),
          },
        );

      if (response.statusCode == 201) {
        print('creacion de nuevo participante exitosa: ${response.statusCode}');
        // Si la solicitud fue exitosa, actualiza la lista de invitaciones
      // fetchInvitacion();
      } else {
        print('Error al crear nuevo paticipante: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

//obtener estados----------------------------------------------------------------
class EstadoGetServicio {  
  static Future<List<dynamic>> fetchEstado() async {
    final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/estados')); 
    if (response.statusCode == 200) {
      //debugPrint("se cargaron los estados correctamente");
      //print(response.body);                    // Imprimir en consola
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los estados');
    }
  }
}

//obtener rondas----------------------------------------------------------------
//no hay rondas
class RondaGetServicio {  
  static Future<List<dynamic>> fetchRonda() async {
    final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/rondas')); 
    if (response.statusCode == 200) {
      debugPrint("se cargaron las rondas correctamente");
      print(response.body);                    // Imprimir en consola
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar las rondas');
    }
  }
}



