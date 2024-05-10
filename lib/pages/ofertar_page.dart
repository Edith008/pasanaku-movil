import 'package:flutter/material.dart';
//import './servicios.dart';

class OfertarPage extends StatefulWidget {
  @override
  _OfertarPageState createState() => _OfertarPageState();
}

class _OfertarPageState extends State<OfertarPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("aqui se hacen las ofertas", style: TextStyle(color: Colors.white)),  
        backgroundColor: Color.fromARGB(255, 9, 127, 83),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: Column(
        children: [
 
        ],
      ),
    );
  }
}
