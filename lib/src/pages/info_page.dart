import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

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
          _crearAppbar(),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _cardInfo(context),
              SizedBox(
                height: 10,
              ),
              _cardInfoComer(context),
              SizedBox(
                height: 10,
              ),

              // _descripcion(pelicula),
              // _descripcion(pelicula),
              // _descripcion(pelicula),
              // _descripcion(pelicula),
              // _crearCasting(pelicula)
            ]),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar() {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blue,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Hola Mundo',
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

  Widget _cardInfo(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'info', arguments: {'opc': 02});
        },
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
                                            '+57 318-842-4892',
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
                                          Text(
                                            '+ 57 318-842-4892',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Movil',
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
                        Container(
                          // clipBehavior: Clip.antiAlias,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            'lorgiam1026@gmail.com',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _cardInfoComer(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'info', arguments: {'opc': 02});
        },
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
                                            'Calle 10 # 28c-45',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Dirección',
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
