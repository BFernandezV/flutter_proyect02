import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_test/models/mensaje.dart';
import 'package:login_test/src/pages/agregar.dart';
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
  late Future<Post> response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dada),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          child: FutureBuilder<Post>(
              future: response,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Title(
                          color: Color.fromARGB(255, 0, 0, 0),
                          child: Text(
                            snapshot.data!.sector,
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
                            snapshot.data!.descripcion,
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
                                  child: Image.network(
                                    snapshot.data!.url_foto1,
                                    height: 130,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FotoLugar()),
                                    );
                                  }),
                              MaterialButton(
                                  child: Image.network(
                                    snapshot.data!.url_foto2,
                                    height: 130,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FotoLugar()),
                                    );
                                  }),
                            ],
                          ),
                        ),
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
                                  child: Text("Sigue ahi? (" +
                                      snapshot.data!.sigue_ahi.toString() +
                                      ")"),
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
                                  child: Text("Ya no esta (" +
                                      snapshot.data!.ya_no_esta.toString() +
                                      ")"),
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
                                  var postId = snapshot.data!.id.toString();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Agregar(
                                              postID: postId,
                                              sector: snapshot.data!.sector,
                                            )),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          height: 250,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  top: 15,
                                  right: 10,
                                  bottom: 10,
                                ),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.comentarios.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                    color: Color(0xFFFDCB6E),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    // margin: EdgeInsets.all(0),
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot
                                                    .data!.comentarios[i]["id"]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text("por: @" +
                                                      snapshot.data!
                                                              .comentarios[i]
                                                          ["descripcion"]),
                                                  Text(snapshot
                                                          .data!.comentarios[i]
                                                      ["fecha_comentario"]),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // Padding(padding: const EdgeInsets.all(value)),

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
                                }),
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
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ));
                }
                return CircularProgressIndicator();
              }),
        )
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    print("Este es el postId " + widget.postID);
    response = getDataPost();
    // comments = getmensajes();
  }

  Future<Post> getDataPost() async {
    final res = await http.get(Uri.parse(
        'https://882aa2605781.sa.ngrok.io/api/wuakalasApi/Getwuakala?id=' +
            widget.postID.toString()));

    final body = json.decode(res.body);

    final Post post = Post.fromJson(body);
    post.url_foto1 =
        'https://882aa2605781.sa.ngrok.io/images/' + post.url_foto1;
    post.url_foto2 =
        'https://882aa2605781.sa.ngrok.io/images/' + post.url_foto2;
    print(post.comentarios);
    return post;
  }
}
