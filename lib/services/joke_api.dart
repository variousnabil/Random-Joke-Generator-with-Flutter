import 'package:http/http.dart';
import 'dart:convert';

class JokeApi {
  int id;
  String category;
  String type;
  String joke;

  Future<void> getJoke(String url) async {
    Response response = await get('https://sv443.net/jokeapi/category/$url');
    Map data = jsonDecode(utf8.decode(response.bodyBytes));
    print(data);

    id = data['id'];
    category = data['category'];
    type = data['type'];
    joke = type == 'single' ? data['joke'] : data['setup'] + '\n' + data['delivery'];
  }
}
