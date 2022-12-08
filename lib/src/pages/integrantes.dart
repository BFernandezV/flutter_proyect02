import 'package:flutter/material.dart';

import 'side_bar.dart';

class Integrantes extends StatefulWidget {
  const Integrantes({super.key});

  @override
  State<Integrantes> createState() => _IntegrantesState();
}

class _IntegrantesState extends State<Integrantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrantes'),
      ),
      drawer: const NavBar(),
      body: ListView(
        children: [
          ListTile(
            subtitle: Text('Benjamin Fernandez'),
          ),
          ListTile(
            subtitle: Text('Mauricio Furniel'),
          ),
        ],
      ),
    );
  }
}
