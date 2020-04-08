import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rotary/bloc/search_bloc.dart';
import 'package:rotary/src/dto/email_dto.dart';
import 'package:rotary/src/dto/search_dto.dart';
import 'package:rotary/src/models/search.dart';
import 'package:rotary/src/pages/info_page.dart';
import 'package:rotary/src/pages/register_page.dart';
import 'package:rotary/src/providers/http/email_provider.dart';
import 'package:rotary/src/providers/http/search_provider.dart';
import 'package:rotary/src/providers/http/usuario_provider.dart';
import 'package:rotary/src/utils/constants.dart';

class GestionarUsuariosPage extends StatefulWidget {
  GestionarUsuariosPage({Key key}) : super(key: key);

  @override
  _GestionarUsuariosPageState createState() => _GestionarUsuariosPageState();
}

class _GestionarUsuariosPageState extends State<GestionarUsuariosPage> {
  // Input
  TextEditingController buscar = new TextEditingController();

  // Provider
  EmailProvider emailProvider = new EmailProvider();
  var _screenSize;
  //Fields

  String perfil;
  String perfilDialog;
  String estado;
  String estadoDialog;

  //Clases
  SearchDto searchDto;

// Providers
  SearchProvider searchProvider = new SearchProvider();
  UsuarioProvider usuarioProvider = new UsuarioProvider();

  // Blocs
  SearchBloc searchBloc = new SearchBloc();

  // Scroll
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    searchDto = new SearchDto();
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
    searchDto.descripcion = buscar.text;
    searchBloc.searchData(searchDto, 1);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _scrollController.animateTo(_scrollController.position.pixels + 200,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 2500));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionar Usuarios'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(opc: '3'),
                  ));
            },
          ),
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              setState(() {
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
                searchDto.descripcion = buscar.text;
                _mostrarAlert(context);
                setState(() {
                  searchBloc.searchData(searchDto, 1);
                  Timer(Duration(seconds: 1),
                      () => Navigator.of(context).pop('dialog'));
                });
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            width: (_screenSize.width / 2),
                            child: _fieldBuscar()),
                        Container(
                            width: (_screenSize.width / 2) - 50,
                            child: ButtonTheme(
                                child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              textColor: Colors.white,
                              child: Text('Buscar'),
                              onPressed: () {
                                _search();
                              },
                            ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: estado,
                            items: getEstadosDropdown(),
                            onChanged: (opt) {
                              setState(() {
                                estado = opt;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: perfil,
                            items: getPerfilesDropdown(),
                            onChanged: (opt) {
                              setState(() {
                                perfil = opt;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            Expanded(child: _getSocios())
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getEstadosDropdown([String estado]) {
    List<DropdownMenuItem<String>> lista = new List();

    lista
      ..add(DropdownMenuItem(
        child: Text('Seleccione Estado'),
        value: '-1',
      ))
      ..add(DropdownMenuItem(
        child: Text('Inactivo'),
        value: '0',
      ))
      ..add(DropdownMenuItem(
        child: Text('Activo'),
        value: '1',
      ))
      ..add(DropdownMenuItem(
        child: Text('Rechazado'),
        value: '2',
      ));
    if (estado != null) {
      lista.removeWhere((el) => el.value == estado);
    }

    return lista;
  }

  List<DropdownMenuItem<String>> getEstadosDialogDropdown([String estado]) {
    List<DropdownMenuItem<String>> lista = new List();

    lista
      ..add(DropdownMenuItem(
        child: Text('Seleccione Estado'),
        value: '-1',
      ))
      ..add(DropdownMenuItem(
        child: Text('Inactivo'),
        value: '0',
      ))
      ..add(DropdownMenuItem(
        child: Text('Activo'),
        value: '1',
      ))
      ..add(DropdownMenuItem(
        child: Text('Rechazado'),
        value: '2',
      ));
    if (estado != null) {
      lista.removeWhere((el) => el.value == estado);
    }

    return lista;
  }

  List<DropdownMenuItem<String>> getPerfilesDropdown([String perfil]) {
    List<DropdownMenuItem<String>> lista = new List();

    lista
      ..add(DropdownMenuItem(
        child: Text('Seleccione Perfil'),
        value: '-1',
      ))
      ..add(DropdownMenuItem(
        child: Text('Socio'),
        value: 'SOC',
      ))
      ..add(DropdownMenuItem(
        child: Text('Administrador'),
        value: 'ADM',
      ));
    if (perfil != null) {
      lista.removeWhere((el) => el.value == perfil);
    }
    return lista;
  }

  List<DropdownMenuItem<String>> getPerfilesDialogDropdown([String perfil]) {
    List<DropdownMenuItem<String>> lista = new List();

    lista
      ..add(DropdownMenuItem(
        child: Text('Seleccione Perfil'),
        value: '-1',
      ))
      ..add(DropdownMenuItem(
        child: Text('Socio'),
        value: 'SOC',
      ))
      ..add(DropdownMenuItem(
        child: Text('Administrador'),
        value: 'ADM',
      ));

    if (perfil != null) {
      lista.removeWhere((el) => el.value == perfil);
    }

    return lista;
  }

  Widget _fieldBuscar() {
    return TextFormField(
      enabled: true,
      controller: buscar,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre'),
      onSaved: (value) => buscar.text = value,
    );
  }

  _search() {
    searchDto = new SearchDto();
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
    searchDto.descripcion = buscar.text;
    _mostrarAlert(context);
    setState(() {
      searchBloc.searchData(searchDto, 1);
      Timer(Duration(seconds: 1), () => Navigator.of(context).pop('dialog'));
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

  Widget _getSocios() {
    return StreamBuilder(
      stream: searchBloc.dataOpc1Stream,
      builder: (BuildContext context, AsyncSnapshot<List<Search>> snapshot) {
        if (snapshot.hasData) {
          return _listCardsSocios(snapshot.data);
        } else {
          return Center(
            child: Text(
              'No Se Encontraron Socios',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          );
        }
      },
    );
  }

  Widget _listCardsSocios(List<Search> searchs) {
    return ListView.builder(
        itemCount: searchs.length,
        itemBuilder: (context, i) {
          return _cardSocios(context, searchs[i]);
        });
  }

  Widget _cardSocios(BuildContext context, Search search) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoPage(
                search: search,
              ),
            ));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(2.0, 3.0))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  // clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 210,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          search
                                                      .informacionComercialEntity
                                                      .descripcionServicio
                                                      .length >
                                                  0
                                              ? '${search.informacionComercialEntity.descripcionServicio}'
                                              : 'Sin Definir',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Nombre: ${search.nombreCompleto}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Club: ${search.clubEntity.nombreClub}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Ciudad: ${search.ciudadEntity.nombreCiudad}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Direccion: ${search.informacionComercialEntity.direccionComercial}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Telefono: ${search.informacionComercialEntity.telefono}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: FadeInImage(
                                      image: search.imagen == null
                                          ? AssetImage(
                                              'assets/img/rotary-logo.png')
                                          : NetworkImage(
                                              'http://${Constants.URL_API}/file/uploads/img/${search.imagen}'),
                                      placeholder:
                                          AssetImage('assets/img/loading.gif'),
                                      fadeInDuration:
                                          Duration(milliseconds: 200),
                                      height: 80.0,
                                      width: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  new ButtonBar(children: <Widget>[
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      textColor: Colors.blue,
                                      child: Text(
                                        'Cambiar Perfil',
                                        style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        _mostrarAlertInfoPerfil(
                                            context,
                                            search.usuarioEntity.idUsuario,
                                            search.id,
                                            search.usuarioEntity.tipo);
                                      },
                                    ),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      textColor: Colors.blue,
                                      child: Text(
                                        'Cambiar Estado',
                                        style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        _mostrarAlertInfoEstado(
                                            context,
                                            search.usuarioEntity.idUsuario,
                                            search.id,
                                            search.usuarioEntity.estado
                                                .toString());
                                      },
                                    ),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      textColor: Colors.blue,
                                      child: Text(
                                        'Editar',
                                        style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage(
                                                      opc: '4',
                                                      act: 'edt',
                                                      search: search),
                                            ));
                                      },
                                    ),
                                  ]),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  void _mostrarAlertInfoEstado(BuildContext context, int id, int soc,
      [String estadoObj]) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Cambiar Estado'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: estadoDialog,
                            items: getEstadosDialogDropdown(estadoObj),
                            onChanged: (opt) {
                              setState(() {
                                estadoDialog = opt;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cambiar'),
                onPressed: () async {
                  if (estadoDialog != '-1') {
                    _mostrarAlert(context);
                    await usuarioProvider
                        .updateEstado(id, int.parse(estadoDialog))
                        .then((res) async {
                      if (res != null) {
                        if (estadoDialog == '1') {
                          EmailDto emailDto = new EmailDto();
                          emailDto.id = soc;
                          await emailProvider
                              .sendChangePerfil(emailDto)
                              .then((res) async {
                            if (res != null) {
                              estadoDialog = '-1';
                              Navigator.of(context)..pop()..pop();
                              _mostrarAlertInfo(context, 'Operación Exitosa');
                              setState(() {
                                searchDto = new SearchDto();
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
                                searchDto.descripcion = "";
                                searchBloc.searchData(searchDto, 1);
                              });
                            }
                          });
                        } else {
                          estadoDialog = '-1';
                          Navigator.of(context)..pop()..pop();
                          _mostrarAlertInfo(context, 'Operación Exitosa');
                          setState(() {
                            searchDto = new SearchDto();
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
                            searchDto.descripcion = "";
                            searchBloc.searchData(searchDto, 1);
                          });
                        }
                      }
                    }).catchError((err) {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    });
                  }
                },
              ),
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _mostrarAlertInfoPerfil(BuildContext context, int id, int soc,
      [String perfilObj]) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Cambiar Perfil'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: perfilDialog,
                            items: getPerfilesDialogDropdown(perfilObj),
                            onChanged: (opt) {
                              setState(() {
                                perfilDialog = opt;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cambiar'),
                onPressed: () async {
                  if (perfilDialog != '-1') {
                    _mostrarAlert(context);
                    await usuarioProvider
                        .updatePerfil(id, perfilDialog)
                        .then((res) async {
                      if (res != null) {
                        EmailDto emailDto = new EmailDto();
                        emailDto.id = soc;
                        if (perfilDialog == 'ADM') {
                          emailDto.per = 'Administrador';
                        } else if (perfilDialog == 'SOC') {
                          emailDto.per = 'Socio';
                        }
                        await emailProvider
                            .sendChangeEst(emailDto)
                            .then((res) async {
                          if (res != null) {
                            perfilDialog = '-1';
                            Navigator.of(context)..pop()..pop();
                            _mostrarAlertInfo(context, 'Operación Exitosa');
                            setState(() {
                              searchDto = new SearchDto();
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
                              searchDto.descripcion = "";
                              searchBloc.searchData(searchDto, 1);
                            });
                          }
                        });
                      }
                    }).catchError((err) {
                      perfilDialog = '-1';
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      _mostrarAlertInfo(context, 'Operación Exitosa');
                    });
                  }
                },
              ),
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
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
}
