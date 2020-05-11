import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary/bloc/search_bloc.dart';
import 'package:rotary/src/dto/categoria_socio_dto.dart';
import 'package:rotary/src/dto/email_dto.dart';
import 'package:rotary/src/dto/search_dto.dart';
import 'package:rotary/src/models/categoria.dart';
import 'package:rotary/src/models/ciudad.dart';
import 'package:rotary/src/models/club.dart';
import 'package:rotary/src/models/especialidad.dart';
import 'package:rotary/src/models/informacion_comercial.dart';
import 'package:rotary/src/models/search.dart';
import 'package:rotary/src/models/socio.dart';
import 'package:rotary/src/models/usuario.dart';
import 'package:rotary/src/providers/http/categoria_provider.dart';
import 'package:rotary/src/providers/http/categoria_socio_provider.dart';
import 'package:rotary/src/providers/http/ciudad_provider.dart';
import 'package:rotary/src/providers/http/club_provider.dart';
import 'package:rotary/src/providers/http/email_provider.dart';
import 'package:rotary/src/providers/http/especialidad_provider.dart';
import 'package:rotary/src/providers/http/informacion_comercial.dart';
import 'package:rotary/src/providers/http/socio_provider.dart';
import 'package:rotary/src/providers/http/upload_provider.dart';
import 'package:rotary/src/providers/http/usuario_provider.dart';
import 'package:rotary/src/utils/constants.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterPage extends StatefulWidget {
  String opc;
  String per;
  Search search;
  String act;
  RegisterPage({Key key, this.opc, this.search, this.per, this.act})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Providers
  ClubProvider clubProvider = new ClubProvider();
  EspecialidadProvider especialidadProvider = new EspecialidadProvider();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  SocioProvider socioProvider = new SocioProvider();
  EmailProvider emailProvider = new EmailProvider();
  InformacionComercialProvider informacionComercialProvider =
      new InformacionComercialProvider();
  CiudadProvider ciudadProvider = new CiudadProvider();
  UploadProvider uploadProvider = new UploadProvider();
  CategoriaProvider categoriaProvider = new CategoriaProvider();
  CategoriaSocioProvider categoriaSocioProvider = new CategoriaSocioProvider();
  // Blocs
  SearchBloc searchBloc = new SearchBloc();
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
  String _character;
  String perfil;
  String perfilDialog;
  String estado;
  String estadoDialog;

  List categorias = new List();
  List categoriasTmp = new List();
  // Variable de Ancho de la Pantalla
  var _screenSize;
  // Variable File para Visualizacion de la Imagen Tomada o Seleccionada
  File foto;
  // Future
  Future<List<Ciudad>> ciudadFuture;
  Future<List<Club>> clubFuture;
  Future<List<Especialidad>> especialidadFuture;
  Future<List<Categoria>> categoriaFuture;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  // Perfil
  String opc;

  @override
  void initState() {
    super.initState();
    categorias = [];
    ciudadFuture = ciudadProvider.getCiudades();
    clubFuture = clubProvider.getClubes();
    especialidadFuture = especialidadProvider.getEspecialidadesL();
    categoriaFuture = categoriaProvider.getCategorias();
    _character = 'SOC';
    // TODO: implement initState
    if (widget.search != null) {
      nombreCompleto.text = widget.search.nombreCompleto;
      numeroCedula.text = widget.search.numeroCedula;
      correoElectronico.text = widget.search.correoElectronico;
      numeroCelular.text = widget.search.celular;
      nombreComercial.text =
          widget.search.informacionComercialEntity.nombreComercial;
      direccionComercial.text =
          widget.search.informacionComercialEntity.direccionComercial;
      paginacorreo.text = widget.search.informacionComercialEntity.paginaEmail;
      telefono.text = widget.search.informacionComercialEntity.telefono;
      descripcion.text =
          widget.search.informacionComercialEntity.descripcionServicio;
      _date.text =
          formatDate(widget.search.fechaNacimiento, [dd, '-', mm, '-', yyyy]);
      _fecha =
          formatDate(widget.search.fechaNacimiento, [yyyy, '-', mm, '-', dd]);
      ciudad = widget.search.ciudadEntity.nombreCiudad;
      club = widget.search.clubEntity.nombreClub;
      _mostrarFoto(widget.search.imagen);
      (() async {
        await categoriaSocioProvider
            .findCategoriasBySocios(widget.search.id)
            .then((res) {
          res.forEach((x) {
            setState(() {
              categorias.add(x.idCategoria);
              categoriasTmp.add(x.idCategoria);
            });
          });
        });
      })();
    }
    if (widget.opc == '3') {
      widget.per = _character;
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    print(categorias);
    return Scaffold(
      appBar: AppBar(
        title: widget.act == null ? Text('Registro') : Text('Editar'),
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
                child: _mostrarFoto(widget.search?.imagen),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Información Basica',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              widget.opc == '3'
                  ? Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: 120,
                              child: ListTile(
                                  title: const Text('Adminis.'),
                                  leading: Radio(
                                    value: 'SA',
                                    groupValue: _character,
                                    onChanged: (value) {
                                      setState(() {
                                        _character = value;
                                        widget.per = _character;
                                      });
                                    },
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 100,
                              child: ListTile(
                                  title: const Text('Socio'),
                                  leading: Radio(
                                    value: 'SOC',
                                    groupValue: _character,
                                    onChanged: (value) {
                                      setState(() {
                                        _character = value;
                                        widget.per = _character;
                                      });
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ))
                  : SizedBox(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: _dropClubes(),
                      ),
                    ),
                  ],
                ),
              ),
              _dropCategoria(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: _dropCiudades(),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                  width: (_screenSize.width / 2) - 50,
                  child: ButtonTheme(
                      child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    child:
                        widget.act == null ? Text('Registro') : Text('Editar'),
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
      decoration: InputDecoration(
          labelText: 'Nombre Completo',
          counterText: 'Obligatorio *',
          counterStyle: TextStyle(color: Colors.red)),
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
      decoration: InputDecoration(
          labelText: 'Profesión/Especialidad',
          counterText: '',
          counterStyle: TextStyle(color: Colors.red)),
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

  Widget _dropCategoria() {
    print('---- ' + categorias.toString());
    return FutureBuilder(
        future: categoriaFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<Categoria>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          List<dynamic> array = new List();
          snapshot.data.forEach((x) {
            array.add({
              'idCategoria': x.idCategoria,
              'nombreCategoria': x.nombreCategoria
            });
          });

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: _screenSize.width * 0.9,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: MultiSelect(
                        initialValue: categorias,
                        autovalidate: false,
                        titleText: 'Categoria',
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor selecciona una o más opciones';
                          }
                        },
                        errorText: 'Por favor selecciona una o más opciones',
                        dataSource: array,
                        textField: 'nombreCategoria',
                        valueField: 'idCategoria',
                        filterable: true,
                        required: true,
                        value: categorias,
                        onSaved: (value) {
                          print(value);
                          setState(() {
                            categorias = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _fieldNumeroCedula() {
    return TextFormField(
      enabled: true,
      readOnly: widget.act == null ? false : true,
      controller: numeroCedula,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Cedula',
          counterText: 'Obligatorio *',
          counterStyle: TextStyle(color: Colors.red)),
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

          return SearchableDropdown(
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
            hint: new Text('Ciudad *'),
            searchHint: new Text(
              'Seleccione Una Ciudad',
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
        future: especialidadProvider.getEspecialidadesL(),
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
            hint: new Text('Club *'),
            searchHint: new Text(
              'Seleccione Un Club',
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
      readOnly: widget.act == null ? false : true,
      controller: numeroCelular,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Numero de Celular',
          counterText: 'Obligatorio *',
          counterStyle: TextStyle(color: Colors.red)),
      onSaved: (value) => numeroCelular.text = value,
    );
  }

  Widget _fieldCorreoElectronico() {
    return TextFormField(
      enabled: true,
      controller: correoElectronico,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Email',
          counterText: 'Obligatorio *',
          counterStyle: TextStyle(color: Colors.red)),
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
      decoration: InputDecoration(
          labelText: 'Fec. Nacimiento',
          counterText: 'Obligatorio *',
          counterStyle: TextStyle(color: Colors.red)),
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
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _fecha = formatDate(picked, [yyyy, '-', mm, '-', dd]);
        _date.text = formatDate(picked, [dd, '-', mm, '-', yyyy]);
      });
    }
  }

  _mostrarFoto([String imgedt]) {
    //TODO: tengo que hacer este metodo para el perfil
    if (foto == null && imgedt == null) {
      return GestureDetector(
        onTap: () {
          _seleccionarImagen(context);
        },
        child: Image(
            image: AssetImage('assets/img/no-image.png'),
            width: 200,
            height: 200,
            fit: BoxFit.cover),
      );
    } else if (foto == null && imgedt != null) {
      return GestureDetector(
        onTap: () {
          _seleccionarImagen(context);
        },
        child: FadeInImage(
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/img/loading.gif'),
          image:
              NetworkImage('http://${Constants.URL_API}/downloadFile/$imgedt'),
        ),
      );
      // return GestureDetector(
      //     onTap: () {
      //       _seleccionarImagen(context);
      //     },
      //     child: Image.network(imgedt,
      //         width: 200, height: 200, fit: BoxFit.cover));
    } else if (foto != null && imgedt == null) {
      return GestureDetector(
          onTap: () {
            _seleccionarImagen(context);
          },
          child: FadeInImage(
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/loading.gif'),
            image: Image.file(foto, width: 200, height: 200, fit: BoxFit.cover)
                .image,
          ));
    } else if (foto != null && imgedt != null) {
      return GestureDetector(
          onTap: () {
            _seleccionarImagen(context);
          },
          child: FadeInImage(
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/loading.gif'),
            image: Image.file(foto, width: 200, height: 200, fit: BoxFit.cover)
                .image,
          ));
    }
  }

  _seleccionarImagen(BuildContext context) async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto(BuildContext context) async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource source) async {
    foto = await ImagePicker.pickImage(
        maxHeight: 1200, maxWidth: 1200, imageQuality: 100, source: source);
    if (foto != null) {
      //limpieza
    }
    setState(() {});
  }

  _registro() async {
    if (widget.opc == '4') {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
      }
      _mostrarAlert(context);
      Usuario usu = new Usuario();
      Socio soc = new Socio();
      InformacionComercial infoco = new InformacionComercial();
      usu.idUsuario = widget.search.usuarioEntity.idUsuario;
      usu.tipo = widget.search.usuarioEntity.tipo;
      usu.estado = widget.search.usuarioEntity.estado;
      usu.nombreUsuario = numeroCelular.text;
      usu.contrasenia = numeroCedula.text
          .substring(numeroCedula.text.length - 4, numeroCedula.text.length);
      await usuarioProvider
          .update(usu, widget.search.usuarioEntity.idUsuario)
          .then((usu) async {
        if (usu != null) {
          // TODO: Hacer Switch para Preguntar si desea registrar informacion Comercial, por ahora se hace como si todos fueran a registrarla
          infoco.idInformacion =
              widget.search.informacionComercialEntity.idInformacion;
          infoco.nombreComercial = nombreComercial.text;
          infoco.direccionComercial = direccionComercial.text;
          if (ciudad.isNotEmpty) {
            await ciudadFuture.then((ci) {
              infoco.ciudad = ci.firstWhere((el) {
                return el.nombreCiudad == ciudad;
              }).idCiudad;
            });
          }
          infoco.telefono = telefono.text;
          infoco.paginaEmail = paginacorreo.text;
          infoco.descripcionServicio = descripcion.text;
          await informacionComercialProvider
              .update(infoco, infoco.idInformacion)
              .then((info) async {
            if (info != null) {
              soc.idSocio = widget.search.id;
              soc.numeroCedula = numeroCedula.text;
              soc.fechaNacimiento = DateTime.parse(_fecha);
              soc.nombreCompleto = nombreCompleto.text;
              soc.correoElectronico = correoElectronico.text;
              soc.celular = numeroCelular.text;
              soc.informacionComercial = info.idInformacion;
              soc.usuario = usu.idUsuario;
              soc.imagen = widget.search.imagen;
              await clubFuture.then((cl) {
                soc.club = cl.firstWhere((el) {
                  return el.nombreClub == club;
                }).idClub;
              });
              // await especialidadFuture.then((es) {
              //   soc.especialidad = es.firstWhere((el) {
              //     return el.nombreEspecialidad == especialidad;
              //   }).idEspecialidad;
              // });

              await socioProvider.update(soc, soc.idSocio).then((sc) async {
                if (foto != null) {
                  await uploadProvider.save(foto, sc.idSocio);
                }
                if (categorias.length > 0) {
                  categoriasTmp.forEach((el) async {
                    final cat = categorias.firstWhere((e) {
                      return e == el;
                    }, orElse: () {
                      return null;
                    });
                    if (cat == null) {
                      CategoriaSocioDto cts = new CategoriaSocioDto();
                      cts.idCategoria = el;
                      cts.idSocio = sc.idSocio;
                      await categoriaSocioProvider.delete(sc.idSocio, el);
                    }
                  });
                  categorias.forEach((el) async {
                    final cat = categoriasTmp.firstWhere((e) {
                      return e == el;
                    }, orElse: () {
                      return null;
                    });
                    if (cat == null) {
                      CategoriaSocioDto cts = new CategoriaSocioDto();
                      cts.idCategoria = el;
                      cts.idSocio = sc.idSocio;
                      await categoriaSocioProvider.save(cts);
                    }
                  });

                  // categorias.forEach((x) async {
                  //   CategoriaSocioDto cts = new CategoriaSocioDto();
                  //   cts.idCategoria = x;
                  //   cts.idSocio = sc.idSocio;
                  //   await categoriaSocioProvider.save(cts);
                  // });
                }
                if (sc != null) {
                  SearchDto searchDto = new SearchDto();
                  perfil = '-1';
                  estado = '-1';
                  estadoDialog = '-1';
                  perfilDialog = '-1';
                  if (perfil == '-1') {
                    searchDto.perfil = null;
                  } else {
                    searchDto.perfil = perfil;
                  }
                  if (estado == '-1') {
                    searchDto.estado = null;
                  } else {
                    searchDto.estado = int.parse(estado);
                  }
                  searchDto.descripcion = null;
                  EmailDto email = new EmailDto();
                  email.email = correoElectronico.text;
                  email.id = sc.idSocio;
                  if (widget.opc == '1') {
                    await emailProvider.save(email).then((res) {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      _mostrarAlertInfo(context,
                          'Registro Exitoso, su cuenta sera activada por un Administrador, usted sera notificado por correo');
                    });
                  } else if (widget.opc == '2') {
                    await emailProvider.saveSoc(email).then((res) {
                      searchBloc.searchData(searchDto, 1);
                      print(res);
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      _mostrarAlertInfo(context, 'Registro Exitoso');
                    });
                  } else if (widget.opc == '3') {
                    await emailProvider.saveAdm(email).then((res) {
                      searchBloc.searchData(searchDto, 1);
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      _mostrarAlertInfo(context, 'Registro Exitoso');
                    });
                  } else {
                    searchBloc.searchData(searchDto, 1);
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    _mostrarAlertInfo(context, 'Operación Exitosa');
                  }
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
    } else {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
      }
      _mostrarAlert(context);
      Usuario usu = new Usuario();
      Socio soc = new Socio();
      InformacionComercial infoco = new InformacionComercial();

      usu.nombreUsuario = numeroCelular.text;
      if (widget.opc == '1') {
        usu.estado = 0;
      } else {
        usu.estado = 1;
      }
      usu.contrasenia = numeroCedula.text
          .substring(numeroCedula.text.length - 4, numeroCedula.text.length);
      if (widget.per == 'SOC') {
        usu.tipo = 'SOC';
      } else {
        usu.tipo = 'SA';
      }
      await usuarioProvider.save(usu).then((usu) async {
        if (usu != null) {
          // TODO: Hacer Switch para Preguntar si desea registrar informacion Comercial, por ahora se hace como si todos fueran a registrarla
          infoco.nombreComercial = nombreComercial.text;
          infoco.direccionComercial = direccionComercial.text;
          if (ciudad.isNotEmpty) {
            await ciudadFuture.then((ci) {
              infoco.ciudad = ci.firstWhere((el) {
                return el.nombreCiudad == ciudad;
              }).idCiudad;
            });
          }
          infoco.telefono = telefono.text;
          infoco.paginaEmail = paginacorreo.text;
          infoco.descripcionServicio = descripcion.text;
          await informacionComercialProvider.save(infoco).then((info) async {
            if (info != null) {
              soc.numeroCedula = numeroCedula.text;
              soc.fechaNacimiento = DateTime.parse(_fecha);
              soc.nombreCompleto = nombreCompleto.text;
              soc.correoElectronico = correoElectronico.text;
              soc.celular = numeroCelular.text;
              soc.informacionComercial = info.idInformacion;
              soc.usuario = usu.idUsuario;
              await clubFuture.then((cl) {
                soc.club = cl.firstWhere((el) {
                  return el.nombreClub == club;
                }).idClub;
              });
              // await especialidadFuture.then((es) {
              //   soc.especialidad = es.firstWhere((el) {
              //     return el.nombreEspecialidad == especialidad;
              //   }).idEspecialidad;
              // });

              await socioProvider.save(soc).then((sc) async {
                if (foto != null) {
                  await uploadProvider.save(foto, sc.idSocio);
                }
                if (categorias.length > 0) {
                  categorias.forEach((x) async {
                    CategoriaSocioDto cts = new CategoriaSocioDto();
                    cts.idCategoria = x;
                    cts.idSocio = sc.idSocio;
                    await categoriaSocioProvider.save(cts);
                  });
                }
                if (sc != null) {
                  EmailDto email = new EmailDto();
                  email.id = sc.idSocio;
                  email.email = correoElectronico.text;
                  if (widget.opc == '1') {
                    await emailProvider.save(email).then((res) {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      _mostrarAlertInfo(context,
                          'Registro Exitoso, su cuenta sera activada por un Administrador, usted sera notificado por correo');
                    });
                  } else if (widget.opc == '2') {
                    await emailProvider.saveSoc(email).then((res) {
                      print(res);
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      _mostrarAlertInfo(context, 'Registro Exitoso');
                    });
                  } else if (widget.opc == '3') {
                    if (widget.per == 'SOC') {
                      await emailProvider.saveSoc(email).then((res) {
                        print(res);
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                        _mostrarAlertInfo(context, 'Registro Exitoso');
                      });
                    } else {
                      await emailProvider.saveAdm(email).then((res) {
                        print(res);
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                        _mostrarAlertInfo(context, 'Registro Exitoso');
                      });
                    }
                  }
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
  }

  void _mostrarAlertInfo(BuildContext context, String texto) {
    showDialog(
        context: context,
        barrierDismissible: false,
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
                onPressed: () => Navigator.of(context)..pop()..pop(),
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

enum SingingCharacter { lafayette, jefferson }
