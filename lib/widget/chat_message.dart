import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {Key? key,
      required this.texto,
      required this.uid,
      required this.animationController
      
      })
      : super(key: key);

  final String texto;
  final String uid;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return
    // Container(
    //       child: uid == '123' ? _myMessage() : _notMyMessage(),
    //     );
    
     SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          child: uid == '123' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        padding:const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color:const Color(0xff4D9EF6), borderRadius: BorderRadius.circular(20)),
        child: Text(texto, style: const TextStyle(color: Colors.white)),

      ),
    );
  }

  _notMyMessage() {
    
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 50),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: const Color(0xffE4E5E8), borderRadius: BorderRadius.circular(20)),
        child: Text(texto, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}
