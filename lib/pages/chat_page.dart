// ignore_for_file: unused_element

import 'dart:io';
import 'package:chat/models/mesajes_responce.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat/services/chat_service.dart';
import 'package:chat/widget/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late ChatServices chatService;
  late SocketService socketService;
  late AuthServices authService;
  final _texcontroller = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthServices>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(chatService.usuarioPara.uid!);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await chatService.getChat(usuarioID);

    final history = chat.map((m) => ChatMessage(
        texto: m.mensaje!,
        uid: m.de!,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    ChatMessage message = ChatMessage(
      texto: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );
    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  bool _estaEscribiendo = false;
  @override
  Widget build(BuildContext context) {
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(usuarioPara.nombre!.substring(0, 2),
                  style: const TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 3),
            Text(usuarioPara.nombre!,
                style: const TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            itemCount: _messages.length,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, int index) => _messages[index],
          )),
          const Divider(height: 1),
          //caja de texto
          Container(
            // height:100,
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Flexible(
              child: TextField(
            controller: _texcontroller,
            onSubmitted: _handeleSubmit,
            onChanged: (String texto) {
              //cuando hay un valor
              setState(() {
                if (texto.trim().isNotEmpty) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            decoration:
                const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),

          //boton de enviar

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(child: const Text('Enviar'), onPressed: () {})
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: _estaEscribiendo
                              ? () => _handeleSubmit(_texcontroller.text.trim())
                              : null,
                          icon: const Icon(
                            Icons.send,
                          )),
                    ),
                  ),
          )
        ]),
      ),
    );
  }

  _handeleSubmit(String texto) {
    if (texto.isEmpty) return;
    _focusNode.requestFocus();
    _texcontroller.clear();

    final newMessage = ChatMessage(
      texto: texto,
      uid: authService.usuario.uid!,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
      socketService.socket.emit('mensaje-personal', {
        'de': authService.usuario.uid,
        'para': chatService.usuarioPara.uid,
        'mensaje': texto
      });
    });

    @override
    void dispose() {
      for (ChatMessage message in _messages) {
        message.animationController.dispose();
      }
      socketService.socket.off('mensaje-personal');
      super.dispose();
    }
  }
}
