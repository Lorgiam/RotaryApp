import 'package:flutter/material.dart';
import 'package:rotary/src/models/search.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final Search search;
  InfoPage({Key key, this.search}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  var _screenSize;
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
      elevation: 2.0,
      backgroundColor: Colors.blue,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '${search.especialidadEntity.nombreEspecialidad}',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: AssetImage('assets/img/rotary-logo.png'),
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
                                          Text(
                                            '${search.informacionComercialEntity.paginaEmail}',
                                            style: TextStyle(fontSize: 16),
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
}
