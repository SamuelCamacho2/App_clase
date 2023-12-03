import 'package:flutter/widgets.dart';
import 'package:my_app/screens/add_carrera.dart';
import 'package:my_app/screens/add_profesor.dart';
import 'package:my_app/screens/add_tarea.dart';
import 'package:my_app/screens/calendario_screen.dart';
// import 'package:my_app/screens/add_task.dart';
import 'package:my_app/screens/carrera_screen.dart';
import 'package:my_app/screens/dashboard_screem.dart';
import 'package:my_app/screens/favoritas_movie.dart';
import 'package:my_app/screens/profesores_screen.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/tareas_screen.dart';
import 'package:my_app/screens/detail_screen.dart';
import 'package:my_app/screens/popular_screen.dart';
import 'package:my_app/screens/task_screen.dart';

import 'screens/add_task.dart';
// import 'package:my_app/screens/task_screen.dart';



Map<String, WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext context) =>  const DashboardScreen(),
    '/task' : (BuildContext context) =>  const TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
    
    '/carrera' : (BuildContext context) =>  const Carrera_Screen(),
    '/addCarrera' : (BuildContext context) => AddCarrera(),
    
    '/profesor' : (BuildContext context) =>  const Profesor_carrera(),
    '/addProfesor' : (BuildContext context) => AddProfesor(),
    '/AddTarea' : (BuildContext context) => AddTarea(),
    '/tarea' : (BuildContext context) =>  const TareasScreen(),
    '/calendario' : (BuildContext context) => CalendarScreen(),
    '/popular' : (BuildContext context) =>  PopularScreen(),
    '/detail' : (BuildContext context) =>  const DetailScreen(),
    '/favoritas' : (BuildContext context) =>  const favoritScreen(),

    '/register' :(BuildContext context) => RegisterScreen(),
  };
}