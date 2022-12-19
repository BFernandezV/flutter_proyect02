import 'dart:convert';

import 'package:login_test/models/mensaje.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_test/src/pages/avisar.dart';
import 'package:login_test/src/pages/detalles.dart';

class Mensajes extends StatefulWidget {
  const Mensajes({super.key});

  @override
  State<Mensajes> createState() => _MensajesState();
}

class _MensajesState extends State<Mensajes> {
  final url =
      Uri.parse("https://d22292e4f79c.sa.ngrok.io/api/wuakalasApi/Getwuakalas");
  late Future<List<Mensaje>> mensajes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          padding: const EdgeInsets.only(top: 70, bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            color: Color(0xffe9dada),
          ),
          child: Text(
            "Listado de Wakalas",
            style: TextStyle(
                fontFamily: 'Delight Snowy',
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
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
                        return MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            var postId = snap.data![i].id.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Lugares(postID: postId)),
                            );
                          },
                          child: Card(
                            color: Color(0xFFFDCB6E),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.all(0),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 5, bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
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
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(snap.data![i].fecha),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Padding(padding: const EdgeInsets.all(value)),

                                  IconButton(
                                      splashColor: Colors.yellow,
                                      icon: Icon(Icons.chevron_right),
                                      iconSize: 40,
                                      color: Color(0xFF2F3542),
                                      onPressed: () {
                                        var postId =
                                            snap.data![i].id.toString();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Lugares(postID: postId)),
                                        );
                                      }),

                                  // Text(
                                  //   snap.data![i].description,
                                  //   style: TextStyle(),
                                  // ),
                                  // SizedBox(height: 10),
                                  // Divider(),
                                ],
                              ),
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
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Avisar(
                addPost: appendElements,
              ),
            ),
          );
        },
        backgroundColor: Color(0xFF2F3542),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mensajes = getmensajes();
  }

  void appendElements() {
    mensajes = getmensajes();
    setState(() {});
  }

  Future<List<Mensaje>> getmensajes() async {
    final res = await http.get(url);
    final lista = List.from(jsonDecode(res.body));
    List<Mensaje> mensajes = [];
    // List<Mensaje> mensajes = [
    //   Mensaje(fecha: "02/03/2022", id: 0, login: "Benjamin", title: "Primero"),
    //   Mensaje(fecha: "02/03/2022", id: 1, login: "Mauricio", title: "Segundo"),
    //   Mensaje(fecha: "02/03/2022", id: 2, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 3, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 4, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 5, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 6, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 7, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 8, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 9, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 10, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 11, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 12, login: "Jorge", title: "Tercero"),
    //   Mensaje(fecha: "02/03/2022", id: 13, login: "Jorge", title: "Tercero"),
    // ];
    lista.forEach((element) {
      final Mensaje user = Mensaje.fromJson(element);
      mensajes.add(user);
    });
    return mensajes;
  }
}
