import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_app/models/movie_details_model.dart';

class MovieDetailsService {
  var apiKey = 'e71e2ce5db56fa0d6dd0965f7f07d326';

  Future<MovieDetailsModel> getData(id) async {
    print('id :: $id');
    var client = http.Client();
    var movieDetailsModel;
    var baseUrl =
        'https://api.themoviedb.org/3/movie/$id?api_key=apiKey&language=en-US';
    try {
      var res = await client.get(baseUrl);

      if (res.statusCode == 200) {
        var jsonString = res.body;
        print(jsonString);
        var jsonMap = json.decode(jsonString);

        movieDetailsModel = MovieDetailsModel.fromJson(jsonMap);
        print('movieDetailsModel : $movieDetailsModel');
      }
    } catch (Exception) {
      print("Exception : $Exception");
      return movieDetailsModel;
    }
    return movieDetailsModel;
  }
}
