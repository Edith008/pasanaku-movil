import 'package:flutter/material.dart';
import './servicios.dart';
import 'dart:io';
//import 'dart:convert';    //para decodificar el texto del QR
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // Import the foundation package
import 'package:flutter_qr_reader/flutter_qr_reader.dart'; // Importa la biblioteca de escaneo de códigos QR
//import 'package:url_launcher/url_launcher.dart';

class ListaPagosPage extends StatefulWidget {
  @override
  _ListaPagosPageState createState() => _ListaPagosPageState();
    final Map<String, dynamic> juego;       
    ListaPagosPage({required this.juego});
}

class _ListaPagosPageState extends State<ListaPagosPage> {
  List<dynamic> listaParticipantes = [];
  List<dynamic> listaJugadores = [];
  bool isLoading = true;
  File? _imageFile;
  String qrText = '';

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
  }

  Future<void> fetchJugador() async {      
    listaJugadores= await JugadorGetServicio.fetchJugador();
    setState(() {});
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  } 

Future<void> _extractQRData() async {
  if (_imageFile != null) {
    try {
      String extractedText = await FlutterQrReader.imgScan(_imageFile!.path);
      // List<String> parts = extractedText.split('|');
      // String encodedData = parts[0];
      // String identifier = parts.length > 1 ? parts[1] : '';

      // List<int> bytes = base64.decode(encodedData);
      // String decodedText = utf8.decode(bytes);

      setState(() {
        // qrText = 'Datos: $decodedText identificador: $identifier';
        qrText = 'Datos: $extractedText ';
      });
      _showDialog(qrText);
    } on FormatException catch (e) {
      print('Error de formato al extraer datos del QR: ${e.message}');
    } catch (e) {
      print('Error al extraer datos del QR: $e');
    }
  } else {
    print('No se ha seleccionado ninguna imagen.');
  }
}

void _showDialog(String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Codigo del QR:'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cerrar'),
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
        title: Text('Lista de pagos: ${widget.juego['nombreJuego']}', style: TextStyle(color: Colors.white)),  
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
                        Text('ver pesonas que me pagaron', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                    children: [
                      Text('y la fecha de pago'),
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
                      Text('Recibiras: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(widget.juego['moneda'].toString()),
                      SizedBox(width: 5),
                      Text((widget.juego['montoPago'] * widget.juego['cantidadJugadores']).toString()),
                    ],
                  ),

                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                     // setState(() {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Container(
                                constraints: BoxConstraints( maxHeight: MediaQuery.of(context).size.height * 0.9,), // Limita la altura del modal
                                padding: EdgeInsets.all(16),
                                child: SingleChildScrollView( 
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container( 
                                      constraints: BoxConstraints(maxWidth: 250, ), // Limita el ancho del contenedor de la imagen
                                        color: const Color.fromARGB(255, 128, 185, 130),
                                        padding: EdgeInsets.all(8),
                                        child: _imageFile != null
                                            ? kIsWeb
                                                ? Image.network(_imageFile!.path)
                                                : Image.file(_imageFile!)
                                            : Text('No Actualizaste tu QR'), 
                                      ),
                                      
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _pickImage(ImageSource.gallery);
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('Subir QR', style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                    
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: ()  {
                                                _extractQRData();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(255, 72, 68, 144), 
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('Extraer Datos', style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                     // });
                    },

                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 47, 22, 159), 
                      shape: RoundedRectangleBorder( 
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code, color: Colors.white),
                        SizedBox(width: 8), // Espacio entre el icono y el texto
                        Text('Agregar método de pago', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
