import 'package:flutter/material.dart';
import 'package:rotary/src/pages/Info_page.dart';
import 'package:rotary/src/pages/home_page.dart';
import 'package:rotary/src/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'info': (BuildContext context) => InfoPage()
  };
}
