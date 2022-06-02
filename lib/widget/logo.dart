import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
final String titulo;

  const Logo({super.key, required this.titulo});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
                width: 170,
                child: Image(image: AssetImage('assets/tag-logo.png'))),
            Text(titulo, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}