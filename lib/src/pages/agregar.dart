import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_test/src/pages/side_bar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'mensajes.dart';

class Agregar extends StatefulWidget {
  const Agregar({super.key});

  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  @override
  late final pref;
  String login_guardado = "";

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    login_guardado = pref.getString("usuario");
    setState(() {});
  }

  TextEditingController tituloController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Envía tu mensaje'),
        ),
        drawer: NavBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  _titulo(),
                  SizedBox(
                    height: 15.0,
                  ),
                  _descripcion(),
                  SizedBox(
                    height: 15.0,
                  ),
                  _button_enviar(),
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

  Widget _titulo() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            controller: tituloController,
            keyboardType: TextInputType.emailAddress,
            decoration:
                InputDecoration(hintText: 'Titulo', border: myinputborder()),
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
            maxLines: 18,
            controller: descriptionController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Descripción', border: myinputborder()),
            onChanged: (value) {}),
      );
    });
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    if (tituloController.text.isEmpty || descriptionController.text.isEmpty) {
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
      validarDatos(
          tituloController.text, descriptionController.text, _btnController);
    }
  }

  Widget _button_enviar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RoundedLoadingButton(
        child: Text('Enviar mensaje', style: TextStyle(color: Colors.white)),
        controller: _btnController,
        onPressed: _doSomething,
      );
    });
  }

  Future<void> validarDatos(String titulo, String text,
      RoundedLoadingButtonController _buttonController) async {
    final response = await sendService().validar(titulo, text, login_guardado);
    print("Este ese el code:" + response.statusCode.toString());

    if (response.statusCode == 201) {
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
  Future<http.Response> validar(
      String titulo, String texto, String login) async {
    return await http.post(
      Uri.parse('https://40fd422c6d4d.sa.ngrok.io/api/Mensajes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'login': login, 'titulo': titulo, 'texto': texto}),
    );
  }
}
