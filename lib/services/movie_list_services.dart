import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_app/models/movie_list_model.dart';

class MovieListService {
  var baseUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=e71e2ce5db56fa0d6dd0965f7f07d326&language=en-US';
  var apiKey = 'e71e2ce5db56fa0d6dd0965f7f07d326';

  Future<MovieListModel> getData() async {
    var client = http.Client();
    var movieListModel;

    try {
      var res = await client.get(baseUrl);

      if (res.statusCode == 200) {
        var jsonString = res.body;
        print(jsonString);
        var jsonMap = json.decode(jsonString);

        movieListModel = MovieListModel.fromJson(jsonMap);
        // print(movieListModel);
      }
    } catch (Exception) {
      print("Exception : $Exception");
      return movieListModel;
    }
    return movieListModel;
  }
}
