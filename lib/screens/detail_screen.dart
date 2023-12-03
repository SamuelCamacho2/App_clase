import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/movieBD.dart';
import 'package:my_app/models/populart_model.dart';
import 'package:my_app/networks/api_popular.dart';
import 'package:my_app/screens/agregar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _Detail_screenState();
}

// ignore: camel_case_types
class _Detail_screenState extends State<DetailScreen> {
  PopularModel? movie;
  ApiPopular? apiPopular;
  MovieBD? movieBD; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
    movieBD = MovieBD();
  }

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;
    double popularidad = (movie!.voteAverage! / 10) * 5;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
          icon: Icon( Icons.arrow_back_ios),
          onPressed: () {
            setState(() {
              GlobalValues.flagtask.value = !GlobalValues.flagtask.value;
              Navigator.pop(context);
            });
          },
        ),
          title: const Text(
            'Detalles',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
              AspectRatio(
                aspectRatio: 5 / 9,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movie!.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                child: Container(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.6),
                child: Center(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movie!.originalTitle.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<String?>(
                        future: apiPopular!.IdVideo(movie!.id!.toString()),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError || snapshot.data == '') {
                            return const Text(
                              'error al cargar',
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            );
                          } else {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data!,
                                flags: const YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: false,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      color:  Colors.white.withOpacity(0.6),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Flexible(
                          child: Text(
                            movie!.overview!,
                            style: const TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Calificación',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: popularidad,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (popularidad) {
                          print(popularidad);
                        },
                      ), 
                      HeartButton(idpelicula: movie!.id!),
                    ]),
                      
                    FutureBuilder(
                        future: apiPopular!.castMovie(movie!.id!),
                        builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == null) {
                              return Container(
                                height: 200,
                                child: const Center(
                                  child: Text('No hay datos'),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  height: 350,
                                  width: 2000,
                                  child: PageView.builder(
                                      itemCount: 10,
                                      controller: PageController(
                                          viewportFraction:
                                              0.6), // Añade esta línea
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            children: [
                                              Container(
                                                width:
                                                    300.0, // Ajusta este valor según tus necesidades
                                                height:
                                                    280.0, // Ajusta este valor según tus necesidades
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    'https://image.tmdb.org/t/p/w500/${snapshot.data![index]['profile_path']}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text('${snapshot.data![index]['name']}', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Cursive'),),
                                              Text('${snapshot.data![index]['character']}', style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              );
                            }
                          } else {
                            return Container(
                              height: 200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        }),
                  ]),
                ),
              )
            ]),
          ),
        );
  }
}
