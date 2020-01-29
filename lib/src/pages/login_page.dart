import 'package:flutter/material.dart';
import 'package:rotary/bloc/login_bloc.dart';
import 'package:rotary/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
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
            onPressed: () => Navigator.pushNamed(context, 'register'),
          ),
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
    Navigator.pushNamed(context, 'home');
    // Map info = await usuarioProvider.login(bloc.email, bloc.password);

    // if (info['ok']) {
    //   Navigator.pushReplacementNamed(context, 'home');
    // } else {
    //   mostrarAlerta(context, info['mensaje']);
    // }
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
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(90))),
                  child: Image(
                    image: AssetImage('assets/img/rotary-logo.png'),
                    width: 100,
                    height: 100,
                  ))
              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              ,
              SizedBox(height: 10.0, width: double.infinity),
              Text('Rotary International',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
