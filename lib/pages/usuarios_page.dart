import 'dart:async';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_services.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';

import 'package:chat/models/usuario.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  // final RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  final usuarioServide = UsuariosService();

  List<Usuario> usuarios = [];
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  // final List<Usuario> usuarios = [
  //   Usuario(email: 'hola@correo', nombre: 'jose', uid: '1', online: true),
  //   Usuario(email: 'hola@correo', nombre: 'pédrito', uid: '2', online: false),
  //   Usuario(email: 'hola@correo', nombre: 'maria', uid: '3', online: true),
  //   Usuario(email: 'hola@correo', nombre: 'Emilia', uid: '4', online: true),
  // ];

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final usuario = authServices.usuario;
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre.toString(),
            style: const TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
          onPressed: () {
            //desconectar del socket
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthServices.deleteToken();
          },
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(top: 10),
              // child: Icon(Icons.check_circle, color: Colors.blue[400])
              child: socketService.serverStatus == ServerStatus.Online
                  ? Icon(Icons.check_circle, color: Colors.blue[400])
                  : Icon(Icons.offline_bolt, color: Colors.red[400]))
        ],
      ),
      body:

          // _listViewUsuarios(),

          //  SmartRefresher(

          //     controller: _refreshController,
          //     enablePullDown: true,
          //     onRefresh: _cargarUsuarios,
          //     header: WaterDropHeader(
          //       complete: Icon(Icons.check, color: Colors.blue[400]),
          //       waterDropColor: Colors.blue,
          //     ),
          //     child: _listViewUsuarios(),
          //   ),
          LiquidPullToRefresh(
        key: _refreshIndicatorKey, // key if you want to add
        onRefresh: _handleRefresh, // refresh callback
        child: _listViewUsuarios(), // scroll view
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      separatorBuilder: (_, i) => const Divider(),
      itemCount: usuarios.length,
      itemBuilder: (_, i) => _UsuarioListTile(usuarios: usuarios[i]),
    );
  }

  //  _cargarUsuarios() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // _refreshController.refreshCompleted();
  // }

  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();

    usuarios = (await usuarioServide.getUsuarios())!;

    setState(() {});

    completer.complete();
    // Timer(const Duration(seconds: 3), () {
    //   completer.complete();
    // });

    // // print('recarga');
    // setState(() {
    //   // refreshNum = Random().nextInt(100);
    // });
    // return completer.future.then<void>((_) {z
    //   ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Refresh complete'),
    //       action: SnackBarAction(
    //         label: 'RETRY',
    //         onPressed: () {
    //           _refreshIndicatorKey.currentState!.show();
    //         },
    //       ),
    //     ),
    //   );
    // });
  }
}

class _UsuarioListTile extends StatelessWidget {
  const _UsuarioListTile({
    Key? key,
    required this.usuarios,
  }) : super(key: key);

  final Usuario usuarios;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(usuarios.nombre!, style: const TextStyle()),
      subtitle: Text(usuarios.email!),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[300],
        child: Text(
          usuarios.nombre!.substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuarios.online! ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatServices>(context, listen: false);

        chatService.usuarioPara = usuarios;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
