import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
final String titulo;

  const Logo({super.key, required this.titulo});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const SizedBox(
                width: 170,
                child: Image(image: AssetImage('assets/tag-logo.png'))),
            Text(titulo, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}