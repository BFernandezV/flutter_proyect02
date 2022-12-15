import 'dart:ffi';

class Mensaje {
  int id;
  String fecha;
  String login;
  String title;

  Mensaje(
      {required this.fecha,
      required this.id,
      required this.login,
      required this.title});

  factory Mensaje.fromJson(Map json) {
    return Mensaje(
        fecha: json["fecha"],
        id: json["id"],
        login: json["autor"],
        title: json["sector"]);
  }
}

class Post {
  int id;
  String sector;
  String descripcion;
  String fecha_publicacion;
  String autor;
  String url_foto1;
  String url_foto2;
  int sigue_ahi;
  int ya_no_esta;
  List comentarios;

  Post({
    required this.id,
    required this.sector,
    required this.descripcion,
    required this.fecha_publicacion,
    required this.autor,
    required this.url_foto1,
    required this.url_foto2,
    required this.sigue_ahi,
    required this.ya_no_esta,
    required this.comentarios,
  });

  factory Post.fromJson(Map json) {
    return Post(
      id: json["id"],
      sector: json["sector"],
      descripcion: json["descripcion"],
      fecha_publicacion: json["fecha_publicacion"],
      autor: json["autor"],
      url_foto1: json["url_foto1"],
      url_foto2: json["url_foto2"],
      sigue_ahi: json["sigue_ahi"],
      ya_no_esta: json["ya_no_esta"],
      comentarios: json["comentarios"],
    );
  }
}

class Comentarios {
  String nombre;
  String comentario;
  String autor;

  Comentarios(
      {required this.nombre, required this.comentario, required this.autor});

  factory Comentarios.fromJson(Map json) {
    return Comentarios(
        nombre: json["nombre"], comentario: json["id"], autor: json["autor"]);
  }
}
