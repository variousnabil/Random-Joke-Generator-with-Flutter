import 'package:flutter/material.dart';
import 'package:joke_api/services/joke_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  JokeApi jokeApi;
  String joke = 'no joke';
  final List<String> categories = [
    'Programming',
    'Miscellaneous',
    'Dark',
    'Any'
  ];
  bool isButtonDisabled;
  String selectedCategory = 'Programming';

  @override
  void initState() {
    super.initState();
    isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    if (jokeApi == null) {
      jokeApi = ModalRoute.of(context).settings.arguments;
      joke = jokeApi.joke;
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/deadpool.png'),
                      fit: BoxFit.fill)),
            ),
            Positioned(
              right: 20,
              left: 20,
              bottom: 60,
              child: Column(
                children: <Widget>[
                  customCard(isDropdown: true),
                  SizedBox(
                    height: 2,
                  ),
                  customCard(text: joke),
                  SizedBox(
                    height: 25,
                  ),
                  isButtonDisabled
                      ? SpinKitWave(
                          color: Colors.white,
                          size: 20.0,
                        )
                      : RaisedButton.icon(
                          onPressed: () async {
                            setState(() {
                              isButtonDisabled = true;
                            });
                            jokeApi = JokeApi();
                            await jokeApi.getJoke(selectedCategory);
                            setState(() {
                              joke = jokeApi.joke;
                              isButtonDisabled = false;
                            });
                          },
                          color: Colors.white,
                          icon: Icon(Icons.laptop_chromebook),
                          label: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('I want another joke!'),
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customCard({String text, bool isDropdown = false}) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isDropdown == false
            ? Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Category of Joke: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  DropdownButton<String>(
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String selectedCategory) {
                      // execute something when user change the dropdown
                      onDropDownItemSelected(selectedCategory);
                    },
                    value: this.selectedCategory,
                  ),
                ],
              ),
      ),
    );
  }

  void onDropDownItemSelected(String selectedCategory) {
    setState(() {
      this.selectedCategory = selectedCategory;
    });
  }
}
