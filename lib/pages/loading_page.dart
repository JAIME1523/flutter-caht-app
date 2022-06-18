// ignore_for_file: use_build_context_synchronously

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:chat/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
   
  const LoadingPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(
        future:checkLoaginState(context) ,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
        return const Center(
           child: Text('Espere...'),
        );
       },
     
      ),
    );
  }

  Future checkLoaginState(BuildContext context) async{
    final authService = Provider.of<AuthServices>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();
if (autenticado){
  // Navigator.pushReplacementNamed(context, 'usuarios');
 socketService.connect();
  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_ ,__,___,) => const UsuariosPage(), 
  
  transitionDuration: const Duration(milliseconds: 0)
  ));
}else{
  // Navigator.pushReplacementNamed(context, 'login');
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_ ,__,___,) => const LoginPage(), 
  
  transitionDuration: const Duration(milliseconds: 0)
  ));

}
  }
}