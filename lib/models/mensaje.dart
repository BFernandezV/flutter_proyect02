class Mensaje {
  int id;
  String fecha;
  String login;
  String title;
  String description;
  Mensaje(
      {required this.fecha,
      required this.id,
      required this.login,
      required this.title,
      required this.description});

  factory Mensaje.fromJson(Map json) {
    return Mensaje(
        fecha: json["fecha"],
        id: json["id"],
        login: json["login"],
        title: json["titulo"],
        description: json["texto"]);
  }
}
