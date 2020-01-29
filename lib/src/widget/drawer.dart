import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  void initState() {
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
    ls
      ..add(
        new ListTile(
          leading: Icon(Icons.person),
          title: Text('Activar Socios'),
          onTap: () {
            // change app state...
            Navigator.popAndPushNamed(context, 'valid'); // close the drawer
          },
        ),
      )
      ..add(
        new ListTile(
          leading: Icon(Icons.close),
          title: Text('Cerrar Sesion'),
          onTap: () {
            // change app state...
            Navigator.popAndPushNamed(context, 'sincropes'); // close the drawer
          },
        ),
      )
      ..add(
        new ListTile(
          // leading: Icon(Icons.closeap),
          title: Text('Salir'),
          onTap: () {
            // change app state...
            _mostrarAlert(context);
          },
        ),
      );
    return ls;
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            // title: Text('Historia Clinica'),
            content: Text('Desea Salir de la Aplicación'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () {
                  exit(0);
                  // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          );
        });
  }
}
