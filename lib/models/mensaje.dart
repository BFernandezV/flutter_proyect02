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
