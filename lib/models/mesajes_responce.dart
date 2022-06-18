// To parse this JSON data, do
//
//     final mensajesResponce = mensajesResponceFromJson(jsonString);

import 'dart:convert';

MensajesResponce mensajesResponceFromJson(String str) => MensajesResponce.fromJson(json.decode(str));

String mensajesResponceToJson(MensajesResponce data) => json.encode(data.toJson());

class MensajesResponce {
    MensajesResponce({
        this.ok,
        this.mensajes,
    });

    bool ? ok;
    List<Mensaje>?  mensajes;

    factory MensajesResponce.fromJson(Map<String, dynamic> json) => MensajesResponce(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(json["Mensajes"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "Mensajes": List<dynamic>.from(mensajes!.map((x) => x.toJson())),
    };
}

class Mensaje {
    Mensaje({
        this.de,
        this.para,
        this.mensaje,
        this.createdAt,
        this.updatedAt,
    });

    String? de;
    String? para;
    String? mensaje;
    DateTime?  createdAt;
    DateTime?  updatedAt;

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
    };
}
