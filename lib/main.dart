import 'package:flutter/material.dart';
import 'package:login_test/src/pages/login_page.dart';
import 'package:login_test/src/pages/side_bar.dart';

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
      home: LoginPage(),
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
