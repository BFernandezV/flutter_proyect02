import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_test/models/mensaje.dart';
import 'package:login_test/src/pages/detallesfotos.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class Lugares extends StatefulWidget {
  const Lugares({Key? key, required this.postID}) : super(key: key);

  final String postID;

  @override
  State<Lugares> createState() => _LugaresState();
}

class _LugaresState extends State<Lugares> {
  late Future<List<Mensaje>> comments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dada),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Title(
              color: Color.fromARGB(255, 0, 0, 0),
              child: Text(
                "Lugar donde es la Cuestion",
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 6, 25, 237),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pink Acapella'),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "miaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiaumiau",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Delight Snowy'),
                textAlign: TextAlign.center,
              ),
            )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      child: Image.asset(
                        'assets/images/repugnante.png',
                        height: 130,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FotoLugar()),
                        );
                      }),
                  MaterialButton(
                      child: Image.asset(
                        'assets/images/repugnante.png',
                        height: 130,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FotoLugar()),
                        );
                      }),
                ],
              ),
            ),
            // Expanded(
            //     child: SingleChildScrollView(
            //   child: FutureBuilder<List<Comentarios>>(
            //     future: comments,
            //     builder: (context, snap) {},
            //   ),
            // )),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 50,
                      minWidth: 25,
                      disabledColor: Colors.amber,
                      child: Text("Sigue ahi? (30)"),
                      splashColor: Color.fromARGB(255, 255, 7, 226),
                      color: Color(0xffe9dada),
                      onPressed: () {
                        print("Hola Raised Button");
                      },
                    ),
                    SizedBox(
                      width: 55,
                    ),
                    MaterialButton(
                      height: 50.0,
                      minWidth: 25,
                      disabledColor: Colors.amber,
                      child: Text("Ya no esta (1)"),
                      splashColor: Color.fromARGB(255, 255, 7, 226),
                      color: Color(0xffe9dada),
                      onPressed: () {
                        print("Hola Raised Button");
                      },
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("comentarios"),
                  SizedBox(
                    width: 100,
                  ),
                  MaterialButton(
                    height: 30.0,
                    minWidth: 25,
                    disabledColor: Colors.amber,
                    child: Text("Comentar"),
                    splashColor: Color.fromARGB(255, 255, 7, 226),
                    color: Color(0xffe9dada),
                    onPressed: () {
                      print("Hola Raised Button");
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                        "agregar comentarions con todo el show pero necesito el furutr buldier se hace parecido a los mensjaes")
                  ],
                ),
              ),
            ),
            MaterialButton(
              height: 50.0,
              minWidth: 822,
              disabledColor: Colors.amber,
              child: Text("Volver al Litado"),
              splashColor: Color.fromARGB(255, 255, 7, 226),
              color: Color(0xffe9dada),
              onPressed: () {
                print("Hola Raised Button");
              },
            ),
          ],
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    print("Este es el postId " + widget.postID);
    final response = getDataPost();
    // comments = getmensajes();
  }

  Future<Post> getDataPost() async {
    final res = await http.get(Uri.parse(
        'https://5d3069c93e55.sa.ngrok.io/api/wuakalasApi/Getwuakala?id=' +
            widget.postID.toString()));

    final body = json.decode(res.body);

    final Post post = Post.fromJson(body);
    return post;
  }
}
