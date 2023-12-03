import 'package:flutter/material.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/database/movieBD.dart';
import 'package:my_app/models/movies_model.dart';

class HeartButton extends StatefulWidget {
  final int idpelicula;

  HeartButton({required this.idpelicula});
  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool _isFavorited = false;
  MovieBD? movieBD;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBD = MovieBD();
    _checkFavorited();
  }

  void _checkFavorited() async {
    List<movieModel> movies = await movieBD!.ListarPeliculas2();
    for (var movie in movies) {
      if (movie.idMovie == widget.idpelicula && movie.validar == 1) {
        setState(() {
          _isFavorited = true;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 35,
      icon: Icon(
        _isFavorited ? Icons.favorite : Icons.favorite_border,
        color: _isFavorited ? Colors.red : Colors.black,
      ),
      onPressed: () {
        setState(() {
          _isFavorited = !_isFavorited;
          GlobalValues.flagtask.value = !GlobalValues.flagtask.value;
          if(_isFavorited){
            print('Agregado a favoritos');
            movieBD!.INSERT('tblMovies', {'idmovie': widget.idpelicula ,'validar': 1})
            .then((value ){
              var msj = ( value > 0 ) 
                ? 'La inserción fue exitosa!'
                : 'Ocurrió un error';
                }
              );
          }else{
            print('Eliminado de favoritos');
            movieBD!.DELETE('tblMovies', widget.idpelicula).then((value){
              
            }
            );
          }
          
        });
      },
    );
  }
}