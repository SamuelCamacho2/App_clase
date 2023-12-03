import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:my_app/models/populart_model.dart';

class ApiPopular {
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=8af6bb9b252f0faa0ba8ab02575db84d');

  Future<List<PopularModel>?> getAllPopular() async {
    var response = await http.get(link);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['results'] as List;
      return jsonResult
          .map((popular) => PopularModel.fromMap(popular))
          .toList();
    }
    return null;
  }

  Future<String> IdVideo(String id) async {
    Uri video = Uri.parse('https://api.themoviedb.org/3/movie/$id/videos?api_key=8af6bb9b252f0faa0ba8ab02575db84d');
    var response = await http.get(video);
    var jsonResult = jsonDecode(response.body)['results'] as List;
    if(response.statusCode == 200){
      return jsonResult[0]['key'];
    }else{
      return '';
    }
  }

  Future<List<dynamic>?> castMovie(int id) async{
    Uri cast = Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=8af6bb9b252f0faa0ba8ab02575db84d');
    var response = await http.get(cast);
    var jsonResult = jsonDecode(response.body)['cast'] as List;
    if (response.statusCode == 200) {
      return jsonResult;
    }
    return null;
  }
}
