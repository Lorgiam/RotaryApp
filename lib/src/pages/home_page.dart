import 'package:flutter/material.dart';
import 'package:rotary/src/models/especialidad.dart';
import 'package:rotary/src/models/socio.dart';
import 'package:rotary/src/providers/http/especialidad_provider.dart';
import 'package:rotary/src/providers/http/socio_provider.dart';
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
  TextEditingController especialidad = new TextEditingController();

  // Scroll
  ScrollController _scrollController = new ScrollController();

  // Providers
  EspecialidadProvider especialidadProvider = new EspecialidadProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _scrollController.animateTo(_scrollController.position.pixels + 100,
            curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));
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
                              onPressed: () {},
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
                            child: _dropEspecialidad())
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
            hint: new Text('Especialidad'),
            searchHint: new Text(
              'Seleccione Una',
              style: new TextStyle(fontSize: 20),
            ),
            onChanged: (value) {
              setState(() {
                especialidad.text = value;
              });
            },
          );
        });
  }

  Widget _getSocios() {
    final socioProvider = new SocioProvider();
    return FutureBuilder(
      future: socioProvider.getSocios(),
      builder: (BuildContext context, AsyncSnapshot<List<Socio>> snapshot) {
        if (snapshot.hasData) {
          return _listCardsSocios(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _listCardsSocios(List<Socio> socios) {
    return ListView.builder(
        itemCount: socios.length,
        itemBuilder: (context, i) {
          return _cardSocios(context, socios[i]);
        });
  }

  Widget _cardSocios(BuildContext context, Socio socio) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'info', arguments: {'opc': 02});
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
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 210,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Diseñador de Ropa de Modas',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Diseñador de Ropa de Modas',
                                          style: TextStyle(
                                            fontSize: 14,
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
                                        Navigator.pushNamed(context, 'lote',
                                            arguments: {'opc': 02});
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
}
