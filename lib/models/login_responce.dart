// To parse this JSON data, do
//
//     final loginResponce = loginResponceFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/usuario.dart';

LoginResponce loginResponceFromJson(String str) => LoginResponce.fromJson(json.decode(str));

String loginResponceToJson(LoginResponce data) => json.encode(data.toJson());

class LoginResponce {
    LoginResponce({
        this.ok,
        this.usuario,
        this.token,
    });

    bool? ok;
    Usuario? usuario;
    String? token;

    factory LoginResponce.fromJson(Map<String, dynamic> json) => LoginResponce(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario!.toJson(),
        "token": token,
    };
}