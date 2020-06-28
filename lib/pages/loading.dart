import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:joke_api/services/joke_api.dart';

class Loading extends StatelessWidget {

  void loadingTime(BuildContext context) async {
    await Future.delayed(Duration(seconds: 5));
    var jokeApi = JokeApi();
    await jokeApi.getJoke('Programming');
    Navigator.pushReplacementNamed(context, '/home', arguments: jokeApi);
  }

  @override
  Widget build(BuildContext context) {
    loadingTime(context);
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
