import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String text1;
  final String text2;

  const Labels(
      {super.key,
      required this.ruta,
      required this.text1,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            // '¿No tienes cuenta?',
            text1,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(text2,
                // 'Crea una ahora! ',
                style:const  TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              
              Navigator.pushReplacementNamed(context, ruta);
            },
          )
        ],
      ),
    );
  }
}
