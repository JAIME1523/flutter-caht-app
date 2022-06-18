import 'package:chat/global/environment.dart';
import 'package:chat/models/mesajes_responce.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatServices extends ChangeNotifier {
  Usuario usuarioPara = Usuario();

  Future getChat(String usuarioID) async {
    var token = await AuthServices.getToken();

    final res = await http
        .get(Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'), headers: {
      'Content-Type': 'application/json',
      'x-token': token!,
    });
    final mesnajesResponse = mensajesResponceFromJson(res.body);
    return mesnajesResponse.mensajes;
  }
}
