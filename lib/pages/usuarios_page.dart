import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final List<Usuario> usuarios = [
    Usuario(email: 'hola@correo', nombre: 'jose', uid: '1', online: true),
    Usuario(email: 'hola@correo', nombre: 'pédrito', uid: '2', online: false),
    Usuario(email: 'hola@correo', nombre: 'maria', uid: '3', online: true),
    Usuario(email: 'hola@correo', nombre: 'Emilia', uid: '4', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuarios", style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(top: 10),
              // child: Icon(Icons.check_circle, color: Colors.blue[400])
              child: Icon(Icons.offline_bolt, color: Colors.red[400]))
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue,
        ),
        child: _listViewUsuarios(),
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

  void _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
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
    );
  }
}
