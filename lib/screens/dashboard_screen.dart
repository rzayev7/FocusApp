import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_app_project/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_app_project/models/task_model.dart';
import 'package:focus_app_project/services/task_service.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Color _categoryCardColor(BuildContext context, Color lightColor) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900]!
        : lightColor;
  }

  Color _categoryIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.purpleAccent.shade100
        : Colors.black54;
  }

  TextStyle _categoryTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    if (taskProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (taskProvider.error != null) {
      return Center(child: Text('Error: \\${taskProvider.error}'));
    }
    final allTasks = taskProvider.tasks;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('26 Dec', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_task');
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.0,
                  children: [
                    _CategoryCard(
                      color: _categoryCardColor(context, const Color(0xFFE8E9FF)),
                      icon: Icons.favorite,
                      iconColor: _categoryIconColor(context),
                      count: allTasks.where((t) => t.tag == 'Health').length,
                      label: 'Health',
                      textStyle: _categoryTextStyle(context),
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Health', 'tasks': allTasks});
                      },
                    ),
                    _CategoryCard(
                      color: _categoryCardColor(context, const Color(0xFFDFF7E8)),
                      icon: Icons.check_box,
                      iconColor: _categoryIconColor(context),
                      count: allTasks.where((t) => t.tag == 'Work').length,
                      label: 'Work',
                      textStyle: _categoryTextStyle(context),
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Work', 'tasks': allTasks});
                      },
                    ),
                    _CategoryCard(
                      color: _categoryCardColor(context, const Color(0xFFF1D7F0)),
                      icon: Icons.self_improvement,
                      iconColor: _categoryIconColor(context),
                      count: allTasks.where((t) => t.tag == 'Mental Health').length,
                      label: 'Mental Health',
                      textStyle: _categoryTextStyle(context),
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Mental Health', 'tasks': allTasks});
                      },
                    ),
                    _CategoryCard(
                      color: _categoryCardColor(context, const Color(0xFFE5E3E3)),
                      icon: Icons.folder,
                      iconColor: _categoryIconColor(context),
                      count: allTasks.where((t) => t.tag == 'Others').length,
                      label: 'Others',
                      textStyle: _categoryTextStyle(context),
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Others', 'tasks': allTasks});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (allTasks.isEmpty)
                  Center(
                    child: Text(
                      'No tasks yet. Tap + to create one.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  )
                else
                  ...allTasks.map((task) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/task_detail',
                        arguments: task,
                      );
                    },
                    child: _TaskItem(
                      title: task.title,
                      tag: task.tag.toUpperCase(),
                      subtasks: task.subtasks,
                      isDone: task.isDone,
                      onDoneChanged: (val) async {
                        await TaskService.updateTaskStatus(
                          TaskModel(
                            id: task.id,
                            title: task.title,
                            tag: task.tag,
                            date: task.date,
                            subtasks: task.subtasks,
                            isDone: val,
                            createdBy: task.createdBy,
                            createdAt: task.createdAt,
                          ),
                          val,
                        );
                      },
                    ),
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Color iconColor;
  final int count;
  final String label;
  final TextStyle textStyle;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.count,
    required this.label,
    required this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: Theme.of(context).brightness == Brightness.dark
              ? LinearGradient(
                  colors: [color.withOpacity(0.7), Colors.black12],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$count', style: textStyle),
                Text(label, style: textStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String title;
  final String tag;
  final List<String>? subtasks;
  final bool isDone;
  final ValueChanged<bool> onDoneChanged;

  const _TaskItem({
    required this.title,
    required this.tag,
    this.subtasks,
    required this.isDone,
    required this.onDoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: isDone,
                onChanged: (val) {
                  if (val != null) onDoneChanged(val);
                },
                activeColor: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tag,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isDark ? Colors.purpleAccent.shade100 : Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          if (subtasks != null && subtasks!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 8),
              child: Column(
                children: subtasks!
                    .map((sub) => Row(
                          children: [
                            Checkbox(value: false, onChanged: (_) {}),
                            const SizedBox(width: 8),
                            Expanded(child: Text(sub)),
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
