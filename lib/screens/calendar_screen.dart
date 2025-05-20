import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Group tasks by date string
    Map<String, List<TaskModel>> tasksByDate = {};
    for (var task in tasks) {
      tasksByDate.putIfAbsent(task.date, () => []).add(task);
    }

    String selectedDateStr = _selectedDay != null
        ? DateFormat('dd MMM yyyy').format(_selectedDay!)
        : DateFormat('dd MMM yyyy').format(_focusedDay);
    final selectedTasks = tasksByDate[selectedDateStr] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: isDark ? Colors.red[200] : Colors.red),
                defaultTextStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: Theme.of(context).textTheme.titleMedium!,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  String dateStr = DateFormat('dd MMM yyyy').format(date);
                  if ((tasksByDate[dateStr] ?? []).isNotEmpty) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tasks for $selectedDateStr',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: selectedTasks.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks for this day.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      ),
                    )
                  : ListView.separated(
                      itemCount: selectedTasks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final task = selectedTasks[index];
                        return Card(
                          color: isDark ? Colors.grey[900] : Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: task.isDone ? Colors.green : Colors.grey,
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                decoration: task.isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            subtitle: Text(task.tag),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 