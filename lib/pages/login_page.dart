// ignore_for_file: use_build_context_synchronously

import 'package:chat/helper/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                Logo(titulo: 'Messenger'),
                _From(),
                Labels(
                  ruta: 'register',
                  text1: '¿No tienes cuenta?',
                  text2: 'Crea una ahora!',
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

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(
      context,
    );

    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
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
              text: 'Ingresar',
              onPress: authServices.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authServices.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());

                      if (loginOk) {
                        //navegar a otra pantalla
                        //conectar a nuestro token server;
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        //Mostrar alerta
                        motsrarAlerta((context), 'Login incorrecto', 'Rebice sus credenciales ');
                      }
                    })
        ],
      ),
    );
  }
}
