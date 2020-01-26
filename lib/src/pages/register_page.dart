import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Input
  TextEditingController nombreCompleto = new TextEditingController();
  TextEditingController numeroCedula = new TextEditingController();
  TextEditingController correoElectronico = new TextEditingController();
  TextEditingController numeroCelular = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  String _fecha = '';
  // Variable de Ancho de la Pantalla
  var _screenSize;
  // Variable File para Visualizacion de la Imagen Tomada o Seleccionada
  File foto;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                _tomarFoto(context);
              }),
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {
              _seleccionarImagen(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 150,
                height: 150,
                child: _mostrarFoto(),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: _screenSize.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: _fieldNumeroCedula(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: _fieldFechaNacimiento(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: _screenSize.width * 0.9,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _fieldNombreCompleto(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: _screenSize.width * 0.9,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _fieldCorreoElectronico(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: _screenSize.width * 0.9,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _fieldNumeroCelular(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: _screenSize.width * 0.9,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MultiSelect(
                          autovalidate: false,
                          titleText: 'Categoria',
                          validator: (value) {
                            if (value == null) {
                              return 'Por favor selecciona una o más opciones';
                            }
                          },
                          errorText: 'Por favor selecciona una o más opciones',
                          dataSource: [
                            {
                              "display": "Australia",
                              "value": 1,
                            },
                            {
                              "display": "Canada",
                              "value": 2,
                            },
                            {
                              "display": "India",
                              "value": 3,
                            },
                            {
                              "display": "United States",
                              "value": 4,
                            }
                          ],
                          textField: 'display',
                          valueField: 'value',
                          filterable: true,
                          required: true,
                          value: null,
                          onSaved: (value) {
                            print('The value is $value');
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldNombreCompleto() {
    return TextFormField(
      enabled: true,
      controller: nombreCompleto,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre Completo'),
      onSaved: (value) => nombreCompleto.text = value,
    );
  }

  Widget _fieldNumeroCedula() {
    return TextFormField(
      enabled: true,
      controller: numeroCedula,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Numero de Cedula'),
      onSaved: (value) => numeroCedula.text = value,
    );
  }

  Widget _fieldNumeroCelular() {
    return TextFormField(
      enabled: true,
      controller: numeroCelular,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Numero de Celular'),
      onSaved: (value) => numeroCelular.text = value,
    );
  }

  Widget _fieldCorreoElectronico() {
    return TextFormField(
      enabled: true,
      controller: correoElectronico,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Correo Electronico'),
      onSaved: (value) => correoElectronico.text = value,
    );
  }

  Widget _fieldFechaNacimiento(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _date,
      decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
      onTap: () {
        //Linea para quitar el foco del elemento
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _fecha = formatDate(picked, [yyyy, '-', mm, '-', dd]);
        _date.text = formatDate(picked, [dd, '-', mm, '-', yyyy]);
      });
    }
  }

  _mostrarFoto() {
    //TODO: tengo que hacer este metodo para el perfil

    return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        width: 200,
        height: 200,
        fit: BoxFit.cover);
  }

  _seleccionarImagen(BuildContext context) async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto(BuildContext context) async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource source) {
    foto = await ImagePicker.pickImage(source: ImageSource.camera);
    if (foto != null) {
      //limpieza
    }
    setState(() {});
  }
}
