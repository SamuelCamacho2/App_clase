import 'package:flutter/material.dart';
import 'package:my_app/database/tareasdb.dart';
import 'package:my_app/models/tarea_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Instanciamos la base de datos
  TareaDB db = TareaDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
      ),
      body: FutureBuilder<List<TareaModelo>>(
        future: db.ListarTareas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              eventLoader: (day) {
                return _getTareasForDay(day, snapshot.data!);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _showTareaDetails(selectedDay, snapshot.data!);
                  });
                }
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ocurrió un error'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<TareaModelo> _getTareasForDay(DateTime day, List<TareaModelo> tareas) {
    // Filtramos las tareas basadas en la fecha
    return tareas.where((tarea) => isSameDay(tarea.fechaExpiracion, day)).toList();
  }

  void _showTareaDetails(DateTime day, List<TareaModelo> tareas) {
    // Obtenemos las tareas para el día seleccionado
    List<TareaModelo> tareasForDay = _getTareasForDay(day, tareas);

    // Mostramos un modal con los detalles de las tareas
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: tareasForDay.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tareasForDay[index].nombreTarea!),
              subtitle: Text('Descripción: ${tareasForDay[index].descripcionTarea}\nEstatus: ${tareasForDay[index].realizada == 1 ? 'Realizada' : 'No realizada'}'),
            );
          },
        );
      },
    );
  }
}