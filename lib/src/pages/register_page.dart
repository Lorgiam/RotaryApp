import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary/src/dto/email_dto.dart';
import 'package:rotary/src/models/ciudad.dart';
import 'package:rotary/src/models/club.dart';
import 'package:rotary/src/models/especialidad.dart';
import 'package:rotary/src/models/informacion_comercial.dart';
import 'package:rotary/src/models/socio.dart';
import 'package:rotary/src/models/usuario.dart';
import 'package:rotary/src/providers/http/ciudad_provider.dart';
import 'package:rotary/src/providers/http/club_provider.dart';
import 'package:rotary/src/providers/http/especialidad_provider.dart';
import 'package:rotary/src/providers/http/informacion_comercial.dart';
import 'package:rotary/src/providers/http/socio_provider.dart';
import 'package:rotary/src/providers/http/upload_provider.dart';
import 'package:rotary/src/providers/http/usuario_provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Providers
  ClubProvider clubProvider = new ClubProvider();
  EspecialidadProvider especialidadProvider = new EspecialidadProvider();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  SocioProvider socioProvider = new SocioProvider();
  InformacionComercialProvider informacionComercialProvider =
      new InformacionComercialProvider();
  CiudadProvider ciudadProvider = new CiudadProvider();
  UploadProvider uploadProvider = new UploadProvider();
  // Input
  TextEditingController nombreCompleto = new TextEditingController();
  TextEditingController numeroCedula = new TextEditingController();
  TextEditingController correoElectronico = new TextEditingController();
  TextEditingController numeroCelular = new TextEditingController();
  TextEditingController nombreComercial = new TextEditingController();
  TextEditingController direccionComercial = new TextEditingController();
  TextEditingController paginacorreo = new TextEditingController();
  TextEditingController telefono = new TextEditingController();
  TextEditingController descripcion = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  String _fecha = '';
  String club;
  String especialidad;
  String ciudad;
  // Variable de Ancho de la Pantalla
  var _screenSize;
  // Variable File para Visualizacion de la Imagen Tomada o Seleccionada
  File foto;
  // Future
  Future<List<Ciudad>> ciudadFuture;
  Future<List<Club>> clubFuture;
  Future<List<Especialidad>> especialidadFuture;

  @override
  void initState() {
    ciudadFuture = ciudadProvider.getCiudades();
    clubFuture = clubProvider.getClubes();
    especialidadFuture = especialidadProvider.getEspecialidades();
    // TODO: implement initState
    super.initState();
  }

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
              SizedBox(
                height: 20,
              ),
              Text(
                'Información Basica',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: _dropClubes(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: _dropEspecialidad(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Información Comercial',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: _screenSize.width * 0.9,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _fieldNombreComercial(),
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
                      child: _fieldDireccionComercial(),
                    ),
                  ],
                ),
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
                        child: _dropCiudades(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: _fieldNumeroComercial(),
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
                      child: _fieldCorreoElectronicoComercial(),
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
                              "display": "Alimentos",
                              "value": 1,
                            },
                            {
                              "display": "Tecnologia",
                              "value": 2,
                            },
                            {
                              "display": "Viajes",
                              "value": 3,
                            },
                            {
                              "display": "Medicina",
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: _screenSize.width * 0.9,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: descripcionServicio(),
                    ),
                  ],
                ),
              ),
              Container(
                  width: (_screenSize.width / 2) - 50,
                  child: ButtonTheme(
                      child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    child: Text('Registrarse'),
                    onPressed: () {
                      _registro();
                    },
                  ))),
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

  Widget _fieldNombreComercial() {
    return TextFormField(
      enabled: true,
      controller: nombreComercial,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre Comercial'),
      onSaved: (value) => nombreComercial.text = value,
    );
  }

  Widget descripcionServicio() {
    return TextFormField(
      enabled: true,
      maxLines: 3,
      controller: descripcion,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Descripcion del Servicio'),
      onSaved: (value) => descripcion.text = value,
    );
  }

  Widget _fieldDireccionComercial() {
    return TextFormField(
      enabled: true,
      controller: direccionComercial,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Dirección Comercial'),
      onSaved: (value) => direccionComercial.text = value,
    );
  }

  Widget _fieldNumeroComercial() {
    return TextFormField(
      enabled: true,
      controller: telefono,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Telefono Comercial'),
      onSaved: (value) => telefono.text = value,
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

  Widget _dropCiudades() {
    return FutureBuilder(
        future: ciudadProvider.getCiudades(),
        builder: (BuildContext context, AsyncSnapshot<List<Ciudad>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return new SearchableDropdown(
            isExpanded: true,
            items: snapshot.data.map((x) {
              final nme = x.nombreCiudad.trim();
              return new DropdownMenuItem(
                child: Container(
                  width: 155.0,
                  child: new Text(
                    nme,
                    overflow: TextOverflow.visible,
                  ),
                ),
                value: x.nombreCiudad.trim(),
              );
            }).toList(),
            value: ciudad,
            hint: new Text('Ciudad'),
            searchHint: new Text(
              'Seleccione Una',
              style: new TextStyle(fontSize: 20),
            ),
            onChanged: (value) {
              setState(() {
                ciudad = value;
              });
            },
          );
        });
  }

  Widget _dropEspecialidad() {
    return FutureBuilder(
        future: especialidadProvider.getEspecialidades(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Especialidad>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return new SearchableDropdown(
            isExpanded: true,
            items: snapshot.data.map((x) {
              final nme = x.nombreEspecialidad.trim();
              return new DropdownMenuItem(
                child: Container(
                  width: 155.0,
                  child: new Text(
                    nme,
                    overflow: TextOverflow.visible,
                  ),
                ),
                value: x.nombreEspecialidad.trim(),
              );
            }).toList(),
            value: especialidad,
            hint: new Text('Especialidad'),
            searchHint: new Text(
              'Seleccione Una',
              style: new TextStyle(fontSize: 20),
            ),
            onChanged: (value) {
              setState(() {
                especialidad = value;
              });
            },
          );
        });
  }

  Widget _dropClubes() {
    return FutureBuilder(
        future: clubProvider.getClubes(),
        builder: (BuildContext context, AsyncSnapshot<List<Club>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return new SearchableDropdown(
            isExpanded: true,
            items: snapshot.data.map((x) {
              final nme = x.nombreClub.trim();
              return new DropdownMenuItem(
                child: Container(
                  width: 155.0,
                  child: new Text(
                    nme,
                    overflow: TextOverflow.visible,
                  ),
                ),
                value: x.nombreClub.trim(),
              );
            }).toList(),
            value: club,
            hint: new Text('Club'),
            searchHint: new Text(
              'Seleccione Una',
              style: new TextStyle(fontSize: 20),
            ),
            onChanged: (value) {
              setState(() {
                club = value;
              });
            },
          );
        });
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
      decoration: InputDecoration(labelText: 'Email'),
      onSaved: (value) => correoElectronico.text = value,
    );
  }

  Widget _fieldCorreoElectronicoComercial() {
    return TextFormField(
      enabled: true,
      controller: paginacorreo,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Pagina Web / Email Comercial'),
      onSaved: (value) => paginacorreo.text = value,
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
    if (foto == null) {
      return Image(
          image: AssetImage('assets/img/no-image.png'),
          width: 200,
          height: 200,
          fit: BoxFit.cover);
    } else {
      return Image.file(foto, width: 200, height: 200, fit: BoxFit.cover);
    }
  }

  _seleccionarImagen(BuildContext context) async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto(BuildContext context) async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource source) async {
    foto = await ImagePicker.pickImage(source: source);
    if (foto != null) {
      //limpieza
    }
    setState(() {});
  }

  _registro() async {
    _mostrarAlert(context);
    Usuario usu = new Usuario();
    Socio soc = new Socio();
    InformacionComercial infoco = new InformacionComercial();

    usu.nombreUsuario = numeroCelular.text;
    usu.estado = 1;
    usu.contrasenia = numeroCedula.text
        .substring(numeroCedula.text.length - 4, numeroCedula.text.length);
    usu.tipo = 'SOC';
    await usuarioProvider.save(usu).then((res) async {
      if (res != null) {
        // TODO: Hacer Switch para Preguntar si desea registrar informacion Comercial, por ahora se hace como si todos fueran a registrarla
        infoco.nombreComercial = nombreComercial.text;
        infoco.direccionComercial = direccionComercial.text;
        await ciudadFuture.then((ci) {
          infoco.ciudad = ci.firstWhere((el) {
            return el.nombreCiudad == ciudad;
          }).id;
        });
        infoco.telefono = telefono.text;
        infoco.paginaEmail = paginacorreo.text;
        infoco.descripcionServicio = descripcion.text;
        await informacionComercialProvider.save(infoco).then((info) async {
          if (info != null) {
            if (foto != null) {
              await uploadProvider.save(foto).then((res) {
                //TODO: Aqui se seteara la url de la imagen cargada
              });
            }
            soc.numeroCedula = numeroCedula.text;
            soc.fechaNacimiento = DateTime.parse(_fecha);
            soc.nombreCompleto = nombreCompleto.text;
            soc.correoElectronico = correoElectronico.text;
            soc.celular = numeroCelular.text;
            clubFuture.then((cl) {
              soc.club = cl.firstWhere((el) {
                return el.nombreClub == club;
              }).id;
            });
            especialidadFuture.then((es) {
              soc.especialidad = es.firstWhere((el) {
                return el.nombreEspecialidad == especialidad;
              }).id;
            });
            await socioProvider.save(soc).then((sc) {
              if (sc != null) {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                EmailDto email = new EmailDto();
                email.email = correoElectronico.text;
                _mostrarAlertInfo(context,
                    'Registro Exitoso, su cuenta sera activada por un Administrador, usted sera notificado por correo');
              } else {
                // TODO: Mostrar Mensaje de Intentarlo Mas Tarde
              }
            });
          } else {
            // TODO: Mostrar Mensaje de Intentarlo Mas Tarde
          }
        });
      } else {
        // TODO: Mostrar Mensaje de Intentarlo Mas Tarde
      }
    }).catchError((err) {
      // TODO: Mostrar Mensaje de Intentarlo Mas Tarde
    });
  }

  void _mostrarAlertInfo(BuildContext context, String texto) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Confirmación'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Text('$texto')],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
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
