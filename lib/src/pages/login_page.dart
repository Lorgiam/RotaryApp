import 'package:flutter/material.dart';
import 'package:rotary/bloc/data_bloc.dart';
import 'package:rotary/bloc/login_bloc.dart';
import 'package:rotary/bloc/provider.dart';
import 'package:rotary/src/dto/auth_dto.dart';
import 'package:rotary/src/pages/register_page.dart';
import 'package:rotary/src/providers/db/db.provider.dart';
import 'package:rotary/src/providers/http/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc;
  Size size;
  @override
  void initState() {
    _validUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context, size, bloc),
      ],
    ));
  }

  Widget _loginForm(BuildContext context, Size size, LoginBloc bloc) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 160.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 60.0),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                _crearEmail(bloc),
                SizedBox(height: 15.0),
                _crearPassword(bloc),
                SizedBox(height: 15.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          FlatButton(
              child: Text('Crear cuenta'),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(opc: '1', per: 'SOC'),
                  ))),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.portrait, color: Colors.blue),
                hintText: '',
                labelText: 'Usuario',
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.blue),
                labelText: 'Contraseña',
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    _mostrarAlert(context);
    DataBloc dataBloc = new DataBloc();
    AuthProvider authProvider = new AuthProvider();
    AuthDto authDto = new AuthDto();
    authDto.username = bloc.email;
    authDto.password = bloc.password;
    await authProvider.login(authDto).then((res) async {
      if (res != null) {
        await DBProvider.db.getUsuario().then((el) async {
          if (el == null) {
            res.contrasenia = bloc.password;
            await DBProvider.db.insertUser(res);
          }
        });
        dataBloc.insertData({'tip': res.tipo, 'usu': res.idUsuario});
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        _mostrarAlertInfo(
            context, 'Credenciales Incorrectas o Usuario Inactivo');
      }
    }).catchError((err) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      _mostrarAlertInfo(context, err);
    });
  }

  _validUser() async {
    _mostrarAlert(context);
    DataBloc dataBloc = new DataBloc();
    AuthProvider authProvider = new AuthProvider();

    await DBProvider.db.getUsuario().then((el) async {
      if (el != null) {
        AuthDto authDto = new AuthDto();
        authDto.username = el.nombreUsuario;
        authDto.password = el.contrasenia;
        await authProvider.login(authDto).then((res) async {
          if (res != null) {
            dataBloc.insertData({
              'tip': res.tipo,
              'usu': res.idUsuario,
              'nme': res.nombreUsuario
            });
            Navigator.of(context, rootNavigator: true).pop('dialog');
            Navigator.pushReplacementNamed(context, 'home');
          } else {
            await DBProvider.db.deleteUsuario(el.nombreUsuario);
            Navigator.of(context, rootNavigator: true).pop('dialog');
            _mostrarAlertInfo(
                context, 'Credenciales Incorrectas o Usuario Inactivo');
          }
        }).catchError((err) {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          _mostrarAlertInfo(context, err);
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      }
    }).catchError((err) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      _mostrarAlertInfo(context, err);
    });
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Colors.blue, Color.fromRGBO(2, 56, 110, 1.0)])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              Image(
                image: AssetImage('assets/img/rotary-logo.png'),
                width: 100,
                height: 100,
              ),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Rotary International',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  void _mostrarAlertInfo(BuildContext context, String texto) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Información'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Text('$texto')],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Entendido'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text('Por favor Espere...'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              ));
        });
  }
}
