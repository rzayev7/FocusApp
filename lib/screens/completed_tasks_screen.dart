import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completedTasks = taskProvider.tasks.where((t) => t.isDone).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: completedTasks.isEmpty
            ? Center(
                child: Text(
                  'No completed tasks yet!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
              )
            : ListView.separated(
                itemCount: completedTasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return Card(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(task.date),
                      trailing: Text(task.tag),
                    ),
                  );
                },
              ),
      ),
    );
  }
} 