import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:my_app/assets/global_values.dart';
import 'package:my_app/screens/login_screens.dart';
import 'package:my_app/assets/datos_login.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bienvenido'),
        ),
        drawer: createDrawer(context)
        );
  }

  Widget createDrawer(context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text('Samuel Camacho'),
              accountEmail: Text('camacho@gmail.com')),
          ListTile(
            leading: const Icon(Icons.web), //Image.network('url')
            trailing: const Icon(Icons.chevron_right),
            title: const Text('data'),
            subtitle: const Text('data 2'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Task Manager'),
            onTap: () => Navigator.pushNamed(context, '/task'),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Carreras Manager'),
            onTap: () => Navigator.pushNamed(context, '/carrera'),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Profesor Manager'),
            onTap: () => Navigator.pushNamed(context, '/profesor'),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Tareas Manager'),
            onTap: () => Navigator.pushNamed(context, '/tarea'),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Calendario'),
            onTap: () => Navigator.pushNamed(context, '/calendario'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled){
              GlobalValues.flagTheme.value = isDarkModeEnabled;
              GlobalValues().guardarValor(isDarkModeEnabled);
            },
          ),
          ListTile(
            leading:  const Icon(Icons.logout),
            title: const Text('salir'),
            onTap: (){
              InicioSesio(user: 'user', pass: 'pass', sesion: false).borrarDatos();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          )
        ],
      ),
    );
  }
}
