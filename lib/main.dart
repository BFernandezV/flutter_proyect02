import 'package:flutter/material.dart';
import 'package:login_test/src/pages/agregar.dart';
import 'package:login_test/src/pages/detallesfotos.dart';
import 'package:login_test/src/pages/detalles.dart';
import 'package:login_test/src/pages/detallesfotos.dart';
import 'package:login_test/src/pages/login_page.dart';
import 'package:login_test/src/pages/side_bar.dart';
import 'package:login_test/src/pages/mensajes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: Mensajes(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // initialRoute: LoginPage.id,
      // routes: {
      //   LoginPage.id: (context) => LoginPage(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sidebar'),
      ),
      drawer: const NavBar(),
      body: const Center(),
    );
  }
}
