import 'dart:convert';

import 'package:login_test/models/mensaje.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_test/src/pages/agregar.dart';

import 'side_bar.dart';

class Mensajes extends StatefulWidget {
  const Mensajes({super.key});

  @override
  State<Mensajes> createState() => _MensajesState();
}

class _MensajesState extends State<Mensajes> {
  final url = Uri.parse(
      "https://5d3069c93e55.sa.ngrok.io/Help/Api/GET-api-wuakalasApi-Getwuakalas");
  late Future<List<Mensaje>> mensajes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: Text("HOLA"),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder<List<Mensaje>>(
                future: mensajes,
                builder: (context, snap) {
                  if (snap.hasData) {
                    return ListView.builder(
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 15,
                          right: 10,
                          bottom: 10,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snap.data!.length,
                        itemBuilder: (context, i) {
                          return Card(
                            color: Color(0xFF9FA8DA),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.all(0),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: 10),
                                  Column(
                                    children: [
                                      Text(
                                        snap.data![i].title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text("por: @" + snap.data![i].login),
                                          Text(snap.data![i].fecha),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Padding(padding: const EdgeInsets.all(value)),
                                  FloatingActionButton(
                                    child: Icon(Icons.arrow_right),
                                    elevation: 10.0,
                                    backgroundColor: Colors.amber,
                                    onPressed: () {},
                                  ),

                                  // Text(
                                  //   snap.data![i].description,
                                  //   style: TextStyle(),
                                  // ),
                                  // SizedBox(height: 10),
                                  // Divider(),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  if (snap.hasError) {
                    return const Center(
                      child: Text("Ocurrio un error con los datos"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Agregar(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.plus_one),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mensajes = getmensajes();
  }

  Future<List<Mensaje>> getmensajes() async {
    // final res = await http.get(url);
    // final lista = List.from(jsonDecode(res.body));
    // List<Mensaje> mensajes = [];
    // lista.forEach((element) {
    //   final Mensaje user = Mensaje.fromJson(element);
    //   mensajes.add(user);
    // });
    List<Mensaje> mensajes = [
      Mensaje(fecha: "02/03/2022", id: 0, login: "Benjamin", title: "Primero"),
      Mensaje(fecha: "02/03/2022", id: 1, login: "Mauricio", title: "Segundo"),
      Mensaje(fecha: "02/03/2022", id: 2, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 3, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 4, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 5, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 6, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 7, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 8, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 9, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 10, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 11, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 12, login: "Jorge", title: "Tercero"),
      Mensaje(fecha: "02/03/2022", id: 13, login: "Jorge", title: "Tercero"),
    ];
    return mensajes;
  }
}
