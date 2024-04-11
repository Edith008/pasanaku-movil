import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JuegoServicio {
  static Future<List<dynamic>> fetchGames() async {
    //final response = await http.get('http://tu-api-nodejs/api/games');
    //final response = await http.get(Uri.parse('http://localhost:3000/api/juegos'));
    //final response = await http.get(Uri.parse('http://127.0.0.1:3000/juegos'));
    final response = await http.get(Uri.parse('http://192.168.0.6:4000/juegos')); //(NAVEGADOR CHROME)
    //final response = await http.get(Uri.parse('http://10.0.2.2:3000/juegos'));
    debugPrint("juegos");      // Imprimir en consola
    debugPrint(response.body); // Imprimir en consola
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los juegos');
    }
  }
}

class NotificacionServicio {
  static Future<List<dynamic>> fetchNotificacion() async {
    final response = await http.get(Uri.parse('http://192.168.0.6:4000/invitaciones')); //(NAVEGADOR CHROME,emulador)
    debugPrint("invitaciones");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar las notificaciones');
    }
  }
}

class UsuarioServicio {
  static Future<List<dynamic>> fetchUsuario() async {
    final response = await http.get(Uri.parse('http://192.168.0.6:3000/juegos')); //(NAVEGADOR CHROME,emulador)
    debugPrint("usuario");
    debugPrint(response.body); // Imprimir en consola
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No se pudo cargar los usuarios');
    }
  }
}