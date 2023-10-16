import 'package:flutter/material.dart';
import 'package:my_app/models/populart_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _Detail_screenState();
}

// ignore: camel_case_types
class _Detail_screenState extends State<DetailScreen> {
  PopularModel? movie;
  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;
    return Scaffold(
      body: Center(
        child: Text(movie!.title!),
      ),
    ); 
  }
}