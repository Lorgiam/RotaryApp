import 'package:flutter/material.dart';
import 'package:rotary/src/pages/Info_page.dart';
import 'package:rotary/src/pages/home_page.dart';
import 'package:rotary/src/pages/login_page.dart';
import 'package:rotary/src/pages/register_admin.dart';
import 'package:rotary/src/pages/register_page.dart';
import 'package:rotary/src/pages/valid_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'info': (BuildContext context) => InfoPage(),
    'register': (BuildContext context) => RegisterPage(),
    'valid': (BuildContext context) => ValidPage(),
    'register_admin': (BuildContext context) => RegisterAdminPage(),
  };
}
