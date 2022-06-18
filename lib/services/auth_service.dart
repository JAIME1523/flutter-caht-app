// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_responce.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';

class AuthServices extends ChangeNotifier {
  Usuario usuario = Usuario();
  bool _autenticando = false;

  bool get autenticando => _autenticando; 
  // Create storage
  final _storage = const FlutterSecureStorage();

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

//Getters del token de forma estaticamente
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, password) async {
    autenticando = true;

    final data = {'email': email, "password": password};
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/'),
        // final resp = await http.post(Uri.parse('http://192.168.8.56:3000/api/login/'),

        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
    // print(resp.body);

    if (resp.statusCode == 200) {
      final loginreponser = loginResponceFromJson(resp.body);
      usuario = loginreponser.usuario!;
      autenticando = false;
      //guardar token
      await _guardarToken(loginreponser.token!);

      return true;
    } else {
      autenticando = false;

      return false;
    }
  }

  Future registrer(String nombre, email, password) async {
    autenticando = true;

    final data = {'email': email, "password": password, "nombre": nombre};
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new/'),
        // final resp = await http.post(Uri.parse('http://192.168.8.56:3000/api/login/'),

        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
    // print(resp.body);

    if (resp.statusCode == 200) {
      final loginreponser = loginResponceFromJson(resp.body);
      usuario = loginreponser.usuario!;
      autenticando = false;
      // guardar token
      await _guardarToken(loginreponser.token!);

      return true;
    } else {
      autenticando = false;
      final resBody = jsonDecode(resp.body);
      return resBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', "x-token": '$token'});
    if (resp.statusCode == 200) {
      final loginreponser = loginResponceFromJson(resp.body);
      usuario = loginreponser.usuario!;
      autenticando = false;
      //guardar token
      await _guardarToken(loginreponser.token!);

      return true;
    } else {
      // autenticando = false;
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
