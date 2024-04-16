import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServicioBase {
  static const String baseUrl = 'http://127.0.0.1:4000';  //para movil fisico
}

class JuegoServicio {
  static Future<List<dynamic>> fetchGames() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:4000/juegos'));       //funciona en chrome
    //final response = await http.get(Uri.parse('http://10.0.2.2:4000/juegos'));      //funciona en emulador
    //final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/juegos'));   //movil fisico
    if (response.statusCode == 200) {
      debugPrint("se cargaron juegos correctamente"); // Imprimir en consola
      //debugPrint(response.body);                    // Imprimir en consola
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los juegos');
    }
  }
}

class InvitacionServicio {   //para listado de notificaciones
  static Future<List<dynamic>> fetchInvitacion() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:4000/invitaciones'));        //funciona en chrome
    //final response = await http.get(Uri.parse('http://10.0.2.2:4000/invitaciones'));       //funciona en emulador
    //final response = await http.get(Uri.parse('${ServicioBase.baseUrl}/invitaciones'));    //movil fisico
    //debugPrint(response.body);
    if (response.statusCode == 200) {
      debugPrint("se cargaron las invitaciones correctamente");
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar las invitaciones');
    }
  }
}

class RegistroUsuarioServicio {   //para registro de usuario
  Future<void> registrarUsuario(String email, String nombre, String telefono, String contrasena) async {
    try {
      var url = Uri.parse('http://127.0.0.1:4000/usuarios/crear-usuario-jugador');      //funciona en chrome
      //var url = Uri.parse('http://127.0.0.1:4000/usuarios/crear-usuario-jugador');    //funciona en emulador
      //var url = Uri.parse('${ServicioBase.baseUrl}/usuarios/crear-usuario-jugador');  //movil fisico 
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

class AuthUsuarioServicio {
  Future<Map<String, dynamic>> authUsuario(String email, String contrasena) async {
    try {
      var url = Uri.parse('http://127.0.0.1:4000/auth/login');       //funciona en chrome
      //var url = Uri.parse('http://10.0.2.2:4000/auth/login');      //funciona en emulador
      //var url = Uri.parse('${ServicioBase.baseUrl}/auth/login');   //movil fisico
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
        //var token = data['accessToken']; // Accediendo a la clave 'accessToken'
        //print('Token JWT: $token');
        return data; // Devuelve el Map con los datos de la respuesta
      } else {
        return {'error': 'Error al iniciar sesión: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }
}


