import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rotary/bloc/data_bloc.dart';
import 'package:rotary/src/models/storage.dart';
import 'package:rotary/src/pages/register_page.dart';
import 'package:rotary/src/providers/db/db.provider.dart';
// import 'package:flutter/services.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Storage storage;
  DataBloc dataBloc = new DataBloc();
  void initState() {
    storage = Storage.fromJson(dataBloc.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Menu',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
            child: ListView(
          children: _listWidget(),
        )),
      ),
    );
  }

  List<Widget> _listWidget() {
    List<Widget> ls = new List();
    if (storage.tip == 'SOC') {
      ls
        ..add(
          new ListTile(
            leading: Icon(Icons.close),
            title: Text('Cerrar Sesion'),
            onTap: () async {
              _mostrarAlert(context, 2, 'Desea Cerrar Sesión');
            },
          ),
        )
        ..add(
          new ListTile(
            // leading: Icon(Icons.closeap),
            title: Text('Salir'),
            onTap: () {
              // change app state...
              _mostrarAlert(context, 1, 'Desea Salir de la Aplicación');
            },
          ),
        );
    } else if (storage.tip == 'SA') {
      ls
        // ..add(
        //   new ListTile(
        //     leading: Icon(Icons.person),
        //     title: Text('Activar Socios'),
        //     onTap: () {
        //       // change app state...
        //       Navigator.popAndPushNamed(context, 'valid'); // close the drawer
        //     },
        //   ),
        // )
        ..add(
          new ListTile(
            leading: Icon(Icons.person),
            title: Text('Gestionar Usuarios'),
            onTap: () {
              // change app state...
              Navigator.popAndPushNamed(context, 'gestion'); // close the drawer
            },
          ),
        )
        // ..add(
        //   new ListTile(
        //     leading: Icon(Icons.person),
        //     title: Text('Registrar Administradores'),
        //     onTap: () {
        //       // change app state...
        //       Navigator.popAndPushNamed(
        //           context, 'register_admin'); // close the drawer
        //     },
        //   ),
        // )
        // ..add(
        //   new ListTile(
        //     leading: Icon(Icons.person),
        //     title: Text('Registrar Socios'),
        //     onTap: () {
        //       // change app state...
        //       Navigator.popAndPushNamed(
        //           context, 'register_admin'); // close the drawer
        //     },
        //   ),
        // )
        ..add(
          new ListTile(
            leading: Icon(Icons.close),
            title: Text('Cerrar Sesion'),
            onTap: () async {
              // change app state...
              // close the drawer
              _mostrarAlert(context, 2, 'Desea Cerrar Sesión');
            },
          ),
        )
        ..add(
          new ListTile(
            // leading: Icon(Icons.closeap),
            title: Text('Salir'),
            onTap: () {
              // change app state...
              _mostrarAlert(context, 1, 'Desea Salir de la Aplicación');
            },
          ),
        );
    }
    return ls;
  }

  void _mostrarAlert(BuildContext context, int tipo, String msg) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            // title: Text('Historia Clinica'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () async {
                  if (tipo == 1) {
                    exit(0);
                  } else {
                    await DBProvider.db.deleteUsuario(storage.nme).then((e) {
                      Navigator.pushReplacementNamed(context, '/');
                    });
                  }
                },
              ),
            ],
          );
        });
  }
}
