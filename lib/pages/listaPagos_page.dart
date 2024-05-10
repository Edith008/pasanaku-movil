import 'package:flutter/material.dart';
//import './servicios.dart';

class ListaPagosPage extends StatefulWidget {
  @override
  _ListaPagosPageState createState() => _ListaPagosPageState();
}

class _ListaPagosPageState extends State<ListaPagosPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lista de pagos", style: TextStyle(color: Colors.white)),  
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
