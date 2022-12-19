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
  late int uno;
  late int dos;
  late Future<Post> response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xffe9dada),
        body: SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          child: FutureBuilder<Post>(
              future: response,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/back2cats.jpg'),
                              fit: BoxFit.cover)),
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 70, bottom: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(20)),
                                color: Color(0xffe9dada),
                              ),
                              child: Title(
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
                            ),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
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
                                              builder: (context) => FotoLugar(
                                                    urlimg: snapshot
                                                        .data!.url_foto1,
                                                    sector:
                                                        snapshot.data!.sector,
                                                  )),
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
                                              builder: (context) => FotoLugar(
                                                    urlimg: snapshot
                                                        .data!.url_foto2,
                                                    sector:
                                                        snapshot.data!.sector,
                                                  )),
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
                                      elevation: 10,
                                      height: 50,
                                      minWidth: 25,
                                      disabledColor: Colors.amber,
                                      child: Text(
                                        "Sigue ahi? (" + uno.toString() + ")",
                                        style: TextStyle(
                                            fontFamily: 'Delight Snowy'),
                                        textAlign: TextAlign.center,
                                      ),
                                      splashColor:
                                          Color.fromARGB(255, 255, 7, 226),
                                      color: Color(0xffe9dada),
                                      onPressed: () {
                                        print("Hola Raised Button");
                                        validarmas(
                                            snapshot.data!.id.toString());
                                        uno++;
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 55,
                                    ),
                                    MaterialButton(
                                      elevation: 10,
                                      height: 50.0,
                                      minWidth: 25,
                                      disabledColor: Colors.amber,
                                      child: Text(
                                        "Ya no esta (" + dos.toString() + ")",
                                        style: TextStyle(
                                            fontFamily: 'Delight Snowy'),
                                        textAlign: TextAlign.center,
                                      ),
                                      splashColor:
                                          Color.fromARGB(255, 255, 7, 226),
                                      color: Color(0xffe9dada),
                                      onPressed: () {
                                        validarmenos(
                                            snapshot.data!.id.toString());
                                        dos++;
                                        setState(() {});
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
                                  Text(
                                    "comentarios",
                                    style:
                                        TextStyle(fontFamily: 'Delight Snowy'),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  MaterialButton(
                                    elevation: 10,
                                    height: 30.0,
                                    minWidth: 25,
                                    disabledColor: Colors.amber,
                                    child: Text(
                                      "Comentar",
                                      style: TextStyle(
                                          fontFamily: 'Delight Snowy'),
                                      textAlign: TextAlign.center,
                                    ),
                                    splashColor:
                                        Color.fromARGB(255, 255, 7, 226),
                                    color: Color(0xffe9dada),
                                    onPressed: () {
                                      var postId = snapshot.data!.id.toString();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Agregar(
                                                  postID: snapshot.data!.id
                                                      .toString(),
                                                  sector: snapshot.data!.sector,
                                                )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                // scrollDirection: Axis.vertical,
                                height:
                                    MediaQuery.of(context).size.height.round() *
                                        0.2,
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5, bottom: 5, right: 10),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        snapshot.data!.comentarios.length,
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
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width
                                                                .round() *
                                                            0.85,
                                                    child: Text(
                                                      snapshot.data!
                                                              .comentarios[i]
                                                          ["descripcion"],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("por: @" +
                                                          snapshot.data!
                                                                  .comentarios[
                                                              i]["autor"]),
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: MaterialButton(
                                elevation: 10,
                                height: 60.0,
                                minWidth: 822,
                                disabledColor: Colors.amber,
                                child: Text(
                                  "Volver al Listado",
                                  style: TextStyle(fontFamily: 'Delight Snowy'),
                                  textAlign: TextAlign.center,
                                ),
                                splashColor: Color.fromARGB(255, 255, 7, 226),
                                color: Color(0xffe9dada),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ));
                }
                return CircularProgressIndicator();
              }),
        )
      ]),
    ));
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
        'https://d22292e4f79c.sa.ngrok.io/api/wuakalasApi/Getwuakala?id=' +
            widget.postID.toString()));

    final body = json.decode(res.body);

    final Post post = Post.fromJson(body);
    post.url_foto1 = 'https://d22292e4f79c.sa.ngrok.io/' + post.url_foto1;
    post.url_foto2 = 'https://d22292e4f79c.sa.ngrok.io/' + post.url_foto2;
    print(post.comentarios);
    uno = post.sigue_ahi;
    dos = post.ya_no_esta;
    return post;
  }
}

Future<http.Response> validarmas(String id) async {
  return await http.put(
    Uri.parse(
        'https://882aa2605781.sa.ngrok.io/api/wuakalasApi/PutSigueAhi?id=' +
            id),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': id,
    }),
  );
}

Future<http.Response> validarmenos(String id) async {
  return await http.put(
    Uri.parse(
        'https://882aa2605781.sa.ngrok.io/api/wuakalasApi/PutYanoEsta?id=' +
            id),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': id,
    }),
  );
}
