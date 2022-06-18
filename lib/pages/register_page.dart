// ignore_for_file: use_build_context_synchronously

import 'package:chat/helper/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Logo(
                  titulo: 'Registro',
                ),
                _From(),
                Labels(
                  ruta: 'login',
                  text1: '¿Ya tienes cuenta?',
                  text2: 'Inicia sescion cone ella!',
                ),
                Text('Terminos y condiciones de suso ',
                    style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _From extends StatefulWidget {
  const _From({Key? key}) : super(key: key);

  @override
  State<_From> createState() => __FromState();
}

class __FromState extends State<_From> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomImput(
              icon: Icons.perm_identity,
              placeholder: 'Nombre',
              textController: nombreCtrl,
              keyboardRype: TextInputType.text),

          CustomImput(
              icon: Icons.mail_outline,
              placeholder: 'Correo',
              textController: emailCtrl,
              keyboardRype: TextInputType.emailAddress),

          CustomImput(
            icon: Icons.password,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          // TextField(),
          BontonAzul(
              color: Colors.blue,
              text: 'Regsitar',
              onPress: authServices.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final registrerOk = await authServices.registrer(
                          nombreCtrl.text, emailCtrl.text, passCtrl.text);

                      if (registrerOk == true) {
                        //navegar a otra pantalla
                        //conectar a nuestro token server;
                        socketService.connect();
                        Navigator.pushReplacementNamed(context, 'usuarios');
                        // authServices.registrer(nombreCtrl.text, emailCtrl.text, passCtrl.text);
                      } else {
                        //Mostrar alerta
                        motsrarAlerta(
                            (context), 'Login incorrecto', registrerOk);
                      }
                    })
        ],
      ),
    );
  }
}
