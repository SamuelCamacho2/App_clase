
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/populart_model.dart';


Widget itemMovieWidget(PopularModel movie, context){
  return GestureDetector(
    onTap: ()=> Navigator.pushNamed(context, '/detail', arguments: movie),
    child: CachedNetworkImage(
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 500),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
      ),
  );
}