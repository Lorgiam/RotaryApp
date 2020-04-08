import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary/bloc/data_bloc.dart';
import 'package:rotary/src/models/search.dart';
import 'package:rotary/src/models/storage.dart';
import 'package:rotary/src/providers/http/socio_provider.dart';
import 'package:rotary/src/providers/http/upload_provider.dart';
import 'package:rotary/src/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final Search search;
  InfoPage({Key key, this.search}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Storage storage;
  DataBloc dataBloc = new DataBloc();
  File foto;
  List<CustomPopupMenu> opts = <CustomPopupMenu>[
    CustomPopupMenu(
        title: 'Cargar Imagen', icon: Icons.photo_size_select_actual),
    CustomPopupMenu(title: 'Tomar Foto', icon: Icons.camera_alt),
  ];
  var _screenSize;
  UploadProvider uploadProvider = new UploadProvider();
  SocioProvider socioProvider = new SocioProvider();

  @override
  void initState() {
    // TODO: implement initState
    storage = Storage.fromJson(dataBloc.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(widget.search),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Información Basica',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              _cardInfo(context, widget.search),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Información Comercial',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _cardInfoComer(context, widget.search),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              _cardInfoComerDet(context, widget.search),
              SizedBox(
                height: 10,
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Search search) {
    return SliverAppBar(
      actions: <Widget>[
        search.usuario == storage.usu
            ? PopupMenuButton<CustomPopupMenu>(
                child: Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: Center(
                    child: Icon(Icons.more_vert),
                  ),
                ),
                elevation: 2.2,
                onSelected: (elem) async {
                  if (elem.title == 'Cargar Imagen') {
                    _seleccionarImagen(context, search.id);
                  } else {
                    _tomarFoto(context, search.id);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return opts.map((CustomPopupMenu opt) {
                    return PopupMenuItem<CustomPopupMenu>(
                        value: opt,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              opt.icon,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            new Text(opt.title)
                          ],
                        ));
                  }).toList();
                },
              )
            : Text('')
      ],
      elevation: 2.0,
      backgroundColor: Colors.blue,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          search.informacionComercialEntity.descripcionServicio.length > 0
              ? '${search.informacionComercialEntity.descripcionServicio}'
              : 'Sin Definir',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        background: FadeInImage(
          image: search.imagen == null
              ? AssetImage('assets/img/rotary-logo.png')
              : NetworkImage(
                  'http://${Constants.URL_API}/file/uploads/img/${search.imagen}'),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _cardInfo(BuildContext context, Search search) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          width: _screenSize.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 0.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              margin: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            final url = 'tel:${search.celular}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            // clipBehavior: Clip.antiAlias,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Icon(
                                            Icons.call,
                                            color: Colors.blue,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        width: _screenSize.width * 0.6,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 1),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${search.celular}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              'Movil',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
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
                        Container(
                          // clipBehavior: Clip.antiAlias,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.blue,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      width: _screenSize.width * 0.6,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${search.nombreCompleto}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Socio',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${search.clubEntity.nombreClub}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Club',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url = 'mailto:${search.correoElectronico}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            // clipBehavior: Clip.antiAlias,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Icon(
                                            Icons.mail,
                                            color: Colors.blue,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        width: _screenSize.width * 0.6,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 1),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${search.correoElectronico}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              'Correo Electronico',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _cardInfoComer(BuildContext context, Search search) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 0.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              margin: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (search
                                .informacionComercialEntity.direccionComercial
                                .contains('#')) {
                              var splitDir = search
                                  .informacionComercialEntity.direccionComercial
                                  .split('#');
                              final url =
                                  'https://maps.google.com/?q=${splitDir[0]} ${splitDir[1]} ${search.ciudadEntity.nombreCiudad}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            } else {
                              final url =
                                  'https://maps.google.com/?q=${search.informacionComercialEntity.direccionComercial} ${search.ciudadEntity.nombreCiudad}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }
                          },
                          child: Container(
                            // clipBehavior: Clip.antiAlias,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Icon(
                                            Icons.room,
                                            color: Colors.blue,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 1),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${search.informacionComercialEntity.direccionComercial}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              'Dirección Comercial',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
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
                        GestureDetector(
                          onTap: () async {
                            final url =
                                'tel:${search.informacionComercialEntity.telefono}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            // clipBehavior: Clip.antiAlias,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Icon(
                                            Icons.call,
                                            color: Colors.blue,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 1),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${search.informacionComercialEntity.telefono}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              'Telefono Comercial',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
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
                        Container(
                          // clipBehavior: Clip.antiAlias,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Icon(
                                          Icons.store,
                                          color: Colors.blue,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      width: _screenSize.width * 0.6,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${search.informacionComercialEntity.nombreComercial}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Nombre Comercial',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${search.ciudadEntity.nombreCiudad}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Ciudad',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (search
                                                  .informacionComercialEntity
                                                  .paginaEmail
                                                  .contains('@')) {
                                                final url =
                                                    'mailto:${search.informacionComercialEntity.paginaEmail}';
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              } else {
                                                final url =
                                                    'https://maps.google.com/?q=${search.informacionComercialEntity.direccionComercial} ${search.ciudadEntity.nombreCiudad}';
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }
                                            },
                                            child: Text(
                                              '${search.informacionComercialEntity.paginaEmail}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            'Pagina/Correo',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _cardInfoComerDet(BuildContext context, Search search) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 0.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              margin: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // clipBehavior: Clip.antiAlias,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Icon(
                                          Icons.message,
                                          color: Colors.blue,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      width: _screenSize.width * 0.6,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${search.informacionComercialEntity.descripcionServicio}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Descripcion del Servicio',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _seleccionarImagen(BuildContext context, int id) async {
    _procesarImagen(ImageSource.gallery, id);
  }

  _tomarFoto(BuildContext context, int id) async {
    _procesarImagen(ImageSource.camera, id);
  }

  _procesarImagen(ImageSource source, int id) async {
    foto = await ImagePicker.pickImage(
        maxHeight: 1200, maxWidth: 1200, imageQuality: 100, source: source);
    if (foto != null) {
      await uploadProvider.save(foto, id);
      await socioProvider.getSocioById((id)).then((el) {
        setState(() {
          widget.search.imagen = el.imagen;
        });
      });
    }
  }
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});

  String title;
  IconData icon;
}
