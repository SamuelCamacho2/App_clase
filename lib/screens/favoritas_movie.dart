import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/movieBD.dart';
import 'package:my_app/models/populart_model.dart';
import 'package:my_app/networks/api_popular.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/widgets/item_movie_widget.dart';


class favoritScreen extends StatefulWidget {
  const favoritScreen({super.key});

  @override
  State<favoritScreen> createState() => _favoritScreenState();
}

class _favoritScreenState extends State<favoritScreen> {
  Future<List<PopularModel>>? favoritas;
  ApiPopular? apiPopular;
  MovieBD? movieBD;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    movieBD = MovieBD();
  }

  Future<List<PopularModel>> getFavoritas() async {
    List<int> favoritasid = await movieBD!.ListarPeliculas();

    List<PopularModel> movies = [];
    for (var id in favoritasid) {
      Uri link = Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=8af6bb9b252f0faa0ba8ab02575db84d');
      var response = await http.get(link);
      if (response.statusCode == 200) {
        var jsonResult = jsonDecode(response.body);
        PopularModel movie = PopularModel.fromMap(jsonResult);
        movies.add(movie);
      }
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<PopularModel>> favoritas = getFavoritas();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagtask,
        builder: (context, value, _) {
          favoritas = getFavoritas();
          return FutureBuilder<List<PopularModel>>(
          future: favoritas,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else if(snapshot.hasError){
              return Center(child: Text('error ${snapshot.error}'),);
            }else{
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return itemMovieWidget(snapshot.data![index], context);
                }, 
              );
            }
          }
        );
        },
        
      ),
    );
  }
}