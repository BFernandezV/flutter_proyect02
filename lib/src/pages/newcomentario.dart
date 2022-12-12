import 'package:flutter/material.dart';

import 'detalles.dart';

class Comentar extends StatefulWidget {
  const Comentar({super.key});

  @override
  State<Comentar> createState() => _ComentarState();
}

class _ComentarState extends State<Comentar> {
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
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/repugnante.png',
                  ),
                ],
              ),
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
                      child: Text("Comentar Wakala"),
                      splashColor: Color.fromARGB(255, 255, 7, 226),
                      color: Color(0xffe9dada),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Lugares()),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      height: 80,
                      minWidth: 400,
                      disabledColor: Colors.amber,
                      child: Text("Me Arrepenti"),
                      splashColor: Color.fromARGB(255, 255, 7, 226),
                      color: Color(0xffe9dada),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Lugares()),
                        );
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
