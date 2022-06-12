import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

motsrarAlerta(BuildContext context, String titulo, String subtitulo) {
 if(Platform.isAndroid){
    
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [MaterialButton(
        elevation: 5,
        textColor: Colors.blue,
        onPressed: () => Navigator.pop(context),
        child: const Text('OK'))],
    ),
  );
   
 }else{


   showCupertinoDialog(context: context, builder: (_) => CupertinoAlertDialog(
     title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: ()=> Navigator.pop(context),
          child: const Text('OK'))
      ]
   )

     
     , );
 }
 

}
