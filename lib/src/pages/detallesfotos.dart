import 'package:flutter/material.dart';
import 'package:login_test/src/pages/detalles.dart';

class FotoLugar extends StatefulWidget {
  const FotoLugar({super.key});

  @override
  State<FotoLugar> createState() => _FotoLugarState();
}

class _FotoLugarState extends State<FotoLugar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dada),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Title(
              color: Color.fromARGB(255, 0, 0, 0),
              child: Text(
                "Detalle del Lugar donde es la Cuestion",
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 6, 25, 237),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pink Acapella'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/repugnante.png',
                  height: 300,
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  MaterialButton(
                      height: 80,
                      minWidth: 400,
                      disabledColor: Colors.amber,
                      child: Text("Volver"),
                      splashColor: Color.fromARGB(255, 255, 7, 226),
                      color: Color(0xffe9dada),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
