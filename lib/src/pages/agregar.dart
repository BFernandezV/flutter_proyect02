import 'dart:async';
import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Agregar extends StatefulWidget {
  const Agregar({Key? key, required this.postID, required this.sector})
      : super(key: key);

  final String postID;
  final String sector;

  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  @override
  late final pref;
  late String idUser;

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    idUser = pref.getString("idUser");
    setState(() {});
  }

  // TextEditingController tituloController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dada),
      body: Container(
          child: SingleChildScrollView(
              child: Container(
        height: MediaQuery.of(context).size.height.round() * 1,
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
            // SizedBox(
            //   height: 25.0,
            // ),
            _descripcion(),
            // SizedBox(
            //   height: 15.0,
            // ),
            Column(
              children: [
                _button_enviar(),
                // SizedBox(
                //   height: 15.0,
                // ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        MaterialButton(
                          elevation: 10,
                          height: 80,
                          minWidth: 400,
                          // MediaQuery.of(context).size.height.round() * 0.099,
                          // borderRadius: 0,
                          color: Color(0xffe9dada),
                          child: Text('Me Arrepenti',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 140, 0),
                                  fontFamily: 'Pink Acapella',
                                  fontSize: 20)),
                          // controller: _btnController,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargaPreferencia();
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild

        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
          width: 3,
        ));
  }

  // Widget _titulo() {
  //   return StreamBuilder(
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 40),
  //       child: TextField(
  //           controller: tituloController,
  //           keyboardType: TextInputType.emailAddress,
  //           decoration:
  //               InputDecoration(hintText: 'Titulo', border: myinputborder()),
  //           onChanged: (value) {}),
  //     );
  //   });
  // }

  Widget _descripcion() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            maxLines: 18,
            controller: descriptionController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Descripción',
              border: myinputborder(),
            ),
            onChanged: (value) {}),
      );
    });
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    if (descriptionController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Rellena todos los datos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _btnController.error();
      Timer(Duration(seconds: 3), () {
        _btnController.reset();
      });
    } else {
      validarDatos(descriptionController.text, _btnController);
    }
  }

  Widget _button_enviar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: const EdgeInsets.all(25.0),
          child: RoundedLoadingButton(
            elevation: 10,
            width: 400,
            borderRadius: 0,
            height: MediaQuery.of(context).size.height.round() * 0.099,
            color: Color(0xffe9dada),
            child: Text('Comentar Wakala',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 140, 0),
                    fontFamily: 'Pink Acapella',
                    fontSize: 20)),
            controller: _btnController,
            onPressed: _doSomething,
          ));
    });
  }

  Future<void> validarDatos(
      String text, RoundedLoadingButtonController _buttonController) async {
    final response = await sendService()
        .validar(widget.postID, descriptionController.text, idUser);
    print("Este ese el code:" + response.statusCode.toString());

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login
      Fluttertoast.showToast(
          msg: "Mensaje enviado correctamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      _btnController.success();
      Navigator.pop(context);
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Algo ha salido mal :c',
        loopAnimation: false,
        onConfirmBtnTap: () {
          _btnController.reset();
          Navigator.pop(context);
        },
      );
      _btnController.error();
    } // print(
    //     "-----------------------------------------------------------------------------------------------------------------");
    // print("ESTOS SON LOS DATOS QUE LLEGAN:---------------" +
    //     idSector +
    //     descripcion +
    //     idUser);
  }
}

class sendService {
  Future<http.Response> validar(
      String idSector, String descripcion, String idUser) async {
    return await http.post(
      Uri.parse(
          'https://d22292e4f79c.sa.ngrok.io/api/comentariosApi/Postcomentario'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_wuakala': idSector,
        'descripcion': descripcion,
        'id_autor': idUser,
      }),
    );
  }
}
