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
  final url = Uri.parse("https://40fd422c6d4d.sa.ngrok.io/api/mensajes");
  late Future<List<Mensaje>> mensajes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SuperMensajes'),
      ),
      drawer: const NavBar(),
      body: FutureBuilder<List<Mensaje>>(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 10),
                            Text(snap.data![i].fecha),
                            Text(snap.data![i].login),
                            Text(
                              snap.data![i].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              snap.data![i].description,
                              style: TextStyle(),
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Agregar(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.chat),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mensajes = getmensajes();
  }

  Future<List<Mensaje>> getmensajes() async {
    final res = await http.get(url);
    final lista = List.from(jsonDecode(res.body));
    List<Mensaje> mensajes = [];
    lista.forEach((element) {
      final Mensaje user = Mensaje.fromJson(element);
      mensajes.add(user);
    });
    return mensajes;
  }
}
