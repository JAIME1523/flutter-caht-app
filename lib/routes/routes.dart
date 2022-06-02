import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/widgets.dart';

final Map<String, Widget Function(BuildContext) > appRoutes = {
  'usuarios': (_) => const UsuariosPage(),
  'chat':     (_) => const ChatPage(),
  'login':    (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loaging':  (_) => const LoadingPage(),
};
