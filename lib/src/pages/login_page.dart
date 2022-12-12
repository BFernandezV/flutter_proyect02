import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:login_test/src/pages/mensajes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({super.key});
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  late final pref;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffe9dada),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'Wakala.',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pink Acapella'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    'assets/images/repugnante.png',
                    height: 200,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _userTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  _passwordTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  _buttonLogin(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                new Text("By",
                                    style: TextStyle(
                                        fontFamily: 'Delight Snowy',
                                        fontSize: 25))
                              ],
                            ),
                          ),
                          new Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Benjamín Fernández Vera',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Delight Snowy'),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  'Mauricio Furniel Campos',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Delight Snowy'),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> validarDatos(String email, String password,
      RoundedLoadingButtonController _buttonController) async {
    final response = await LoginService().validar(email, password);

    //Por ahora, luego se borra
    _btnController.reset();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Mensajes()));
    _btnController.success();
    // if (response.statusCode == 200) {
    //   //almacenar de alguna manera el login
    //   String name = jsonDecode(response.body);
    //   await pref.setString('usuario', email);
    //   await pref.setString('nombre', name);

    //   Global.login = email;
    //   Global.name = name;
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => Mensajes()));
    //   _btnController.success();
    // } else {
    //   CoolAlert.show(
    //     context: context,
    //     type: CoolAlertType.error,
    //     title: 'Oops...',
    //     text: 'Algo ha salido mal :c',
    //     loopAnimation: false,
    //     onConfirmBtnTap: () {
    //       _btnController.reset();
    //       Navigator.pop(context);
    //     },
    //   );
    //   _btnController.error();
    // }
  }

  String? login_guardado = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargaPreferencia();
  }

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    login_guardado = pref.getString("usuario");
    emailController.text = login_guardado == null ? "" : login_guardado!;
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

  // OutlineInputBorder myfocusborder() {
  //   return OutlineInputBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //       borderSide: BorderSide(
  //         color: Colors.greenAccent,
  //         width: 3,
  //       ));
  // }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            controller: emailController,
            style: TextStyle(fontFamily: 'Delight Snowy'),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'ejemplo@correo.cl',
                border: myinputborder()),
            onChanged: (value) {}),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            controller: passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            style: TextStyle(fontFamily: 'Delight Snowy'),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'Contraseña',
                border: myinputborder()),
            onChanged: (value) {}),
      );
    });
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    if (emailController.text.length == 0) {
      Fluttertoast.showToast(
          msg: "Ingrese un email valido",
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
          emailController.text, passwordController.text, _btnController);
    }
  }

  Widget _buttonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RoundedLoadingButton(
        child: Text('Iniciar Sesión',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pink Acapella',
                fontSize: 20)),
        controller: _btnController,
        onPressed: _doSomething,
        color: Color(0xff2d333f),
      );
    });
  }
}

class LoginService {
  Future<http.Response> validar(String login, String pass) async {
    return await http.post(
      Uri.parse('https://40fd422c6d4d.sa.ngrok.io/api/Usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'login': login, 'pass': pass}),
    );
  }
}

class Global {
  static String login = "";
  static String name = "";
}

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Principal ${Global.login}"),
        ),
        body: Center(
          child: const Text("ඞඞඞඞඞඞඞ login success"),
        ));
  }
}
