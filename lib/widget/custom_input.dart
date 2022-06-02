import 'package:flutter/material.dart';

class CustomImput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardRype;
  final bool isPassword;

  const CustomImput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textController,
       this.keyboardRype = TextInputType.text,
       this.isPassword = false
      
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ]),
      child:  TextField(
        obscureText: isPassword,
        controller: textController,
          autocorrect: false,
          keyboardType: keyboardRype,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: placeholder)),
    );
  }
}
