import 'package:flutter/material.dart';
import 'package:rotary/src/dto/search_dto.dart';
import 'package:rotary/src/models/ciudad.dart';
import 'package:rotary/src/models/especialidad.dart';
import 'package:rotary/src/models/search.dart';
import 'package:rotary/src/pages/info_page.dart';

import 'package:rotary/src/providers/http/ciudad_provider.dart';
import 'package:rotary/src/providers/http/especialidad_provider.dart';
import 'package:rotary/src/providers/http/search_provider.dart';

import 'package:rotary/src/widget/drawer.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Input
  TextEditingController buscar = new TextEditingController();
  String especialidad;
  String ciudad;

  // Scroll
  ScrollController _scrollController = new ScrollController();

  // Providers
  EspecialidadProvider especialidadProvider = new EspecialidadProvider();
  CiudadProvider ciudadProvider = new CiudadProvider();
  SearchProvider searchProvider = new SearchProvider();

  //Future
  Future<List<Search>> searchs;

  //Clases
  SearchDto searchDto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    especialidad = 'Todas';
    ciudad = 'Todas';
    searchDto = new SearchDto();
    if (especialidad == 'Todas') {
      searchDto.especialidad = null;
    } else {
      searchDto.especialidad = especialidad;
    }
    if (ciudad == 'Todas') {
      searchDto.ciudad = null;
    } else {
      searchDto.ciudad = ciudad;
    }
    searchDto.descripcion = buscar.text;
    searchs = searchProvider.getSociosSeach(searchDto);
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
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(
        key: UniqueKey(),
      ),
      appBar: AppBar(
        title: Text('Rotary'),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.menu,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     _scaffoldKey.currentState.openDrawer();
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                buscar.clear();
                especialidad = 'Todas';
                ciudad = 'Todas';
                searchDto = new SearchDto();
                if (especialidad == 'Todas') {
                  searchDto.especialidad = null;
                } else {
                  searchDto.especialidad = especialidad;
                }
                if (ciudad == 'Todas') {
                  searchDto.ciudad = null;
                } else {
                  searchDto.ciudad = ciudad;
                }
                searchDto.descripcion = buscar.text;
                searchs = searchProvider.getSociosSeach(searchDto);
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: (_screenSize.width / 2) - 25,
                            child: _dropEspecialidad()),
                        Container(
                            width: (_screenSize.width / 2) - 25,
                            child: _dropCiudadBySocio())
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

  Widget _fieldBuscar() {
    return TextFormField(
      enabled: true,
      controller: buscar,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Descripción'),
      onSaved: (value) => buscar.text = value,
    );
  }

  Widget _dropCiudadBySocio() {
    return FutureBuilder(
        future: ciudadProvider.getCiudadBySocio(),
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

  Widget _getSocios() {
    return FutureBuilder(
      future: searchs,
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
    print(search.celular);
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
                                          '${search.especialidadEntity.nombreEspecialidad}',
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
                                      image: AssetImage(
                                          'assets/img/rotary-logo.png'),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ButtonTheme(
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      textColor: Colors.blue,
                                      child: Text(
                                        'Ver Mas...',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        print(search.celular);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => InfoPage(
                                                search: search,
                                              ),
                                            ));
                                      },
                                    ),
                                  )
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

  _search() {
    searchDto = new SearchDto();
    if (especialidad == 'Todas') {
      searchDto.especialidad = null;
    } else {
      searchDto.especialidad = especialidad;
    }
    if (ciudad == 'Todas') {
      searchDto.ciudad = null;
    } else {
      searchDto.ciudad = ciudad;
    }
    searchDto.descripcion = buscar.text;

    setState(() {
      searchs = searchProvider.getSociosSeach(searchDto);
    });
  }
}
