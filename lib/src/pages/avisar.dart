import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login_test/src/pages/cameraPage.dart';
import 'dart:typed_data';

class Avisar extends StatefulWidget {
  const Avisar({super.key});

  @override
  State<Avisar> createState() => _AvisarState();
}

late XFile _cameraPhoto1;
late XFile _cameraPhoto2;
TextEditingController sectorController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
bool _loadPhoto1 = false;
bool _loadPhoto2 = false;

class _AvisarState extends State<Avisar> {
  late final pref;
  String idUser = "";

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    idUser = pref.getString("idUser");
    // print("este es el id: " + idUser);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Avisar por nuevo Wakala",
                    style: TextStyle(fontFamily: 'Delight Snowy'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _sector(),
                  SizedBox(
                    height: 15.0,
                  ),
                  _descripcion(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await availableCameras().then((value) =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CameraPage(
                                              cameras: value,
                                              setPhotoCallback: (val) =>
                                                  setState(() => {
                                                        _loadPhoto1 = true,
                                                        _cameraPhoto1 = val
                                                      })))));
                            },
                            child: const Text("Foto 1",
                                style: TextStyle(
                                    fontFamily: 'Delight Snowy', fontSize: 15)),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await availableCameras()
                                  .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CameraPage(
                                                cameras: value,
                                                setPhotoCallback: (val) =>
                                                    setState(() => {
                                                          _loadPhoto2 = true,
                                                          _cameraPhoto2 = val
                                                        }),
                                              ))));
                            },
                            child: const Text("Foto 2",
                                style: TextStyle(
                                    fontFamily: 'Delight Snowy', fontSize: 15)),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _loadPhoto1 != false
                                ? Image.file(File(_cameraPhoto1.path),
                                    fit: BoxFit.cover, width: 50)
                                : Image.asset(
                                    'assets/images/catPicture.png',
                                    height: 72,
                                  ),
                            _loadPhoto2 != false
                                ? Image.file(File(_cameraPhoto2.path),
                                    fit: BoxFit.cover, width: 50)
                                : Image.asset(
                                    'assets/images/catPicture.png',
                                    height: 72,
                                  ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() => {
                                      _loadPhoto1 = false,
                                      _cameraPhoto1 = new XFile("")
                                    });
                              },
                              child: const Text("Borrar",
                                  style: TextStyle(
                                      fontFamily: 'Delight Snowy',
                                      fontSize: 15)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() => {
                                      _loadPhoto2 = false,
                                      _cameraPhoto2 = new XFile("")
                                    });
                              },
                              child: const Text("Borrar",
                                  style: TextStyle(
                                      fontFamily: 'Delight Snowy',
                                      fontSize: 15)),
                            ),
                          ]),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      _button_enviar(),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Me arrepentí",
                            style: TextStyle(
                                fontFamily: 'Delight Snowy', fontSize: 15)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
          color: Colors.redAccent,
          width: 3,
        ));
  }

  Widget _sector() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            controller: sectorController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontFamily: 'Delight Snowy'),
            decoration:
                InputDecoration(hintText: 'Sector', border: myinputborder()),
            onChanged: (value) {}),
      );
    });
  }

  Widget _descripcion() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            maxLines: 3,
            controller: descriptionController,
            style: TextStyle(fontFamily: 'Delight Snowy'),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Descripción', border: myinputborder()),
            onChanged: (value) {}),
      );
    });
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Widget _button_enviar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        child: Text('Denunciar Wakala',
            style: TextStyle(fontFamily: 'Delight Snowy', fontSize: 15)),
        onPressed: _doSomething,
      );
    });
  }

  void _doSomething() async {
    if (sectorController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        (!_loadPhoto1 && !_loadPhoto2)) {
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
      Uint8List imgbytes1 = await _cameraPhoto1.readAsBytes();
      Uint8List imgbytes2 = await _cameraPhoto2.readAsBytes();
      String bs4str1 = base64.encode(imgbytes1);
      String bs4str2 = base64.encode(imgbytes2);
      validarDatos(sectorController.text, descriptionController.text,
          _btnController, bs4str1, bs4str2);
    }
  }

  Future<void> validarDatos(
      String sector,
      String description,
      RoundedLoadingButtonController _buttonController,
      String image1,
      String image2) async {
    final response = await sendService()
        .validar(sector, description, idUser, image1, image2);
    print("Este ese el code:" + response.statusCode.toString());

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Mensaje enviado correctamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      _btnController.success();
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
    }
  }
}

class sendService {
  Future<http.Response> validar(String sector, String description,
      String idUser, String image1, String image2) async {
    return await http.post(
      Uri.parse(
          'https://d22292e4f79c.sa.ngrok.io/api/wuakalasApi/Postwuakalas/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'sector': sector,
        'descripcion': description,
        'id_autor': idUser,
        'base64Foto1': image1,
        "base64Foto2": image2
      }),
    );
  }
}
