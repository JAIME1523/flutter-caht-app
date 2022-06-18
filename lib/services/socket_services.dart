// import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

// ignore: constant_identifier_names
enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting; 
  late Socket _socket;
  ServerStatus get serverStatus => _serverStatus;

  Socket get socket => _socket;

  // SocketService() {
  //   _initCOnfig();
  // }

  void connect() async {

    final token = await AuthServices.getToken();

    String urlSocket ='http://192.168.8.56:3000/';
    // Dart client
    _socket = io(
        urlSocket,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .enableForceNew() //Crea una nueva secion
            .setExtraHeaders({'x-token': token}) // optional
            .build());
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }

  void emit(String valor, var payload){

  }
}
