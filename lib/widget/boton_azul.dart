import 'package:flutter/material.dart';

class BontonAzul extends StatelessWidget {

  final Color color;
  final String text;
  final Function  onPress;

  const BontonAzul({super.key, required this.color, required this.text, required this.onPress}); 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 2, shape: StadiumBorder(), primary: color),
        onPressed: () {
          onPress();
        },
        child: Container(
            height: 55,
            width: double.infinity,
            child: Center(
                child: Text(text, style: TextStyle(fontSize: 17)))));
  }
}
