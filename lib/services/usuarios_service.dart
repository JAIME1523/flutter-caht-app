import 'package:chat/global/environment.dart';
import 'package:chat/models/usuarios_responce.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>?> getUsuarios() async {
    var token = await AuthServices.getToken();
    try {
      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/usuarios/'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token!,
        },
      );

      final usuariosResponce = usuariosResponceFromJson(resp.body);

      return usuariosResponce.usuarios;
    } catch (e) {
      return [];
    }
  }
}
