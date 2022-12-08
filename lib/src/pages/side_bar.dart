import 'package:flutter/material.dart';
import 'package:login_test/src/pages/agregar.dart';
import 'package:login_test/src/pages/integrantes.dart';
import 'package:login_test/src/pages/login_page.dart';
import 'package:login_test/src/pages/mensajes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  late final pref;
  String login_guardado = "";

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    login_guardado = pref.getString("nombre");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargaPreferencia();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Nombre'),
            accountEmail: Text(login_guardado),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2015/01/06/16/14/woman-590490_960_720.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: const NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Mensajes'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Mensajes(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Agregar'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Agregar(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Integrantes'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Integrantes(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text('Salir'),
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return LoginPage();
              }), (r) {
                return false;
              });
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
