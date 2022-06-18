// To parse this JSON data, do
//
//     final usuariosResponce = usuariosResponceFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/usuario.dart';

UsuariosResponce usuariosResponceFromJson(String str) =>
    UsuariosResponce.fromJson(json.decode(str));

String usuariosResponceToJson(UsuariosResponce data) =>
    json.encode(data.toJson());

class UsuariosResponce {
  UsuariosResponce({
    this.ok,
    this.usuarios,
  });

  bool? ok;
  List<Usuario>? usuarios;

  factory UsuariosResponce.fromJson(Map<String, dynamic> json) =>
      UsuariosResponce(
        ok: json["ok"],
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios!.map((x) => x.toJson())),
      };
}
