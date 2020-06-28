import 'package:flutter/material.dart';
import 'package:joke_api/pages/home.dart';
import 'package:joke_api/pages/loading.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => Loading(),
        '/home' : (context) => Home(),
      },
    );
  }
}
