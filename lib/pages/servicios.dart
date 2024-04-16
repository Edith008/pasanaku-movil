import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class JuegoServicio {
  static Future<List<dynamic>> fetchGames() async {
    //final response = await http.get('http://tu-api-nodejs/api/games');
    //final response = await http.get(Uri.parse('http://localhost:3000/api/juegos'));
    //final response = await http.get(Uri.parse('http://127.0.0.1:3000/juegos'));
    final response = await http.get(Uri.parse('http://127.0.0.1:4000/juegos')); //(NAVEGADOR CHROME) funcionaaa
    //final response = await http.get(Uri.parse('http://10.0.2.2:3000/juegos'));
    //final response = await http.get(Uri.parse('192.168.121.55:4000/juegos'));
    if (response.statusCode == 200) {
      debugPrint("se cargaron juegos correctamente");      // Imprimir en consola
      //debugPrint(response.body);                         // Imprimir en consola
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los juegos');
    }
  }
}

class InvitacionServicio {   //para listado de notificaciones
  static Future<List<dynamic>> fetchInvitacion() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:4000/invitaciones')); //(NAVEGADOR CHROME,emulador)
    //debugPrint(response.body);
    if (response.statusCode == 200) {
      debugPrint("se cargaron las invitaciones correctamente");
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar las invitaciones');
    }
  }
}

class UsuarioServicio {
  Future<void> registrarUsuario(String email, String nombre, String telefono, String contrasena) async {
    try {
      var url = Uri.parse('http://127.0.0.1:4000/usuarios/crear-usuario-jugador');
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
      print('Error al registrar usuario: $e');
    }
  }
}
