import 'package:flutter/material.dart';
import 'package:login_test/src/pages/detalles.dart';

class FotoLugar extends StatefulWidget {
  const FotoLugar({Key? key, required this.urlimg, required this.sector})
      : super(key: key);
  final String sector;
  final String urlimg;

  @override
  State<FotoLugar> createState() => _FotoLugarState();
}

class _FotoLugarState extends State<FotoLugar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/back2cats.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 70, bottom: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: Color(0xffe9dada),
                ),
                child: Title(
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: Text(
                    widget.sector,
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
                child: Container(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  child: Image.network(
                    widget.urlimg,
                    height: 300,
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
        ));
  }
}
