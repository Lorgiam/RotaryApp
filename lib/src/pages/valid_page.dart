import 'package:flutter/material.dart';
import 'package:rotary/src/dto/email_dto.dart';
import 'package:rotary/src/models/search.dart';
import 'package:rotary/src/providers/http/email_provider.dart';
import 'package:rotary/src/providers/http/search_provider.dart';
import 'package:rotary/src/providers/http/usuario_provider.dart';
import 'package:rotary/src/utils/constants.dart';

class ValidPage extends StatefulWidget {
  ValidPage({Key key}) : super(key: key);

  @override
  _ValidPageState createState() => _ValidPageState();
}

class _ValidPageState extends State<ValidPage> {
  // Future
  Future<List<Search>> socios;
  //Provider
  SearchProvider searchProvider = new SearchProvider();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  EmailProvider emailProvider = new EmailProvider();
  //Fields
  String _opcionSeleccionada;

  @override
  void initState() {
    // TODO: implement initState
    _opcionSeleccionada = '-1';
    socios = searchProvider.getSociosSeachInactivos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Activar Socios'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: _getSociosInactivos(),
        ));
  }

  Widget _getSociosInactivos() {
    return FutureBuilder(
      future: socios,
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

  Widget _listCardsSocios(List<Search> socios) {
    return ListView.builder(
        itemCount: socios.length,
        itemBuilder: (context, i) {
          return _cardSocios(context, socios[i]);
        });
  }

  Widget _cardSocios(BuildContext context, Search socios) {
    return GestureDetector(
      onTap: () {},
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
                                          '${socios.especialidadEntity.nombreEspecialidad}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Nombre: ${socios.nombreCompleto}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Club: ${socios.clubEntity.nombreClub}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Ciudad: ${socios.ciudadEntity.nombreCiudad}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Direccion: ${socios.informacionComercialEntity.direccionComercial}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Telefono: ${socios.informacionComercialEntity.telefono}',
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
                                      image: socios.imagen == null
                                          ? AssetImage(
                                              'assets/img/rotary-logo.png')
                                          : NetworkImage(
                                              'http://${Constants.URL_API}/file/uploads/img/${socios.imagen}'),
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
                                        'Cambiar Estado',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        _mostrarAlertInfo(
                                            context,
                                            socios.usuarioEntity.idUsuario,
                                            socios.id);
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

  void _mostrarAlertInfo(BuildContext context, int id, int soc) {
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
                            value: _opcionSeleccionada,
                            items: getOpcionesDropdown(),
                            onChanged: (opt) {
                              setState(() {
                                _opcionSeleccionada = opt;
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
                child: Text('Aceptar'),
                onPressed: () async {
                  if (_opcionSeleccionada != 'Seleccione') {
                    _mostrarAlert(context);
                    await usuarioProvider
                        .updateEstado(id, int.parse(_opcionSeleccionada))
                        .then((res) async {
                      if (res != null) {
                        EmailDto emailDto = new EmailDto();
                        emailDto.id = soc;
                        await emailProvider.saveSoc(emailDto).then((res) async {
                          if (res != null) {
                            setState(() {
                              socios = searchProvider.getSociosSeachInactivos();
                            });
                            Navigator.of(context)..pop()..pop();
                          }
                        });
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

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    lista
      ..add(DropdownMenuItem(
        child: Text('Seleccione'),
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

    return lista;
  }
}
