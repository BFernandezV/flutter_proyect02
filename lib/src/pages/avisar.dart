import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:login_test/src/pages/cameraPage.dart';

class Avisar extends StatefulWidget {
  const Avisar({super.key});

  @override
  State<Avisar> createState() => _AvisarState();
}

TextEditingController sectorController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class _AvisarState extends State<Avisar> {
  late XFile _cameraPhoto1;
  late XFile _cameraPhoto2;
  bool _loadPhoto1 = false;
  bool _loadPhoto2 = false;
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
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
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
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          maxLines: 3,
          controller: descriptionController,
          style: TextStyle(fontFamily: 'Delight Snowy'),
          keyboardType: TextInputType.emailAddress,
          decoration:
              InputDecoration(hintText: 'Descripción', border: myinputborder()),
          onChanged: (value) {}),
    );
  });
}

final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();

void _doSomething() async {
  // if (tituloController.text.isEmpty || descriptionController.text.isEmpty) {
  //   Fluttertoast.showToast(
  //       msg: "Rellena todos los datos",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  //   _btnController.error();
  //   Timer(Duration(seconds: 3), () {
  //     _btnController.reset();
  //   });
  // } else {
  //   validarDatos(
  //       tituloController.text, descriptionController.text, _btnController);
  // }
}

Widget _button_enviar() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return ElevatedButton(
      child: Text('Denunciar Wakala',
          style: TextStyle(fontFamily: 'Delight Snowy', fontSize: 15)),
      onPressed: _doSomething,
    );
  });
}
