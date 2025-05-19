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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Today', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('26 Dec', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_task');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
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
                  childAspectRatio: 2.6,
                  children: [
                    _CategoryCard(
                      color: const Color(0xFFE8E9FF),
                      icon: Icons.favorite,
                      count: allTasks.where((t) => t.tag == 'Health').length,
                      label: 'Health',
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Health', 'tasks': allTasks});
                      },
                    ),
                    _CategoryCard(
                      color: const Color(0xFFDFF7E8),
                      icon: Icons.check_box,
                      count: allTasks.where((t) => t.tag == 'Work').length,
                      label: 'Work',
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Work', 'tasks': allTasks});
                      },
                    ),
                    _CategoryCard(
                      color: const Color(0xFFF1D7F0),
                      icon: Icons.self_improvement,
                      count: allTasks.where((t) => t.tag == 'Mental Health').length,
                      label: 'Mental Health',
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Mental Health', 'tasks': allTasks});
                      },
                    ),
                    _CategoryCard(
                      color: const Color(0xFFE5E3E3),
                      icon: Icons.folder,
                      count: allTasks.where((t) => t.tag == 'Others').length,
                      label: 'Others',
                      onTap: () {
                        Navigator.pushNamed(context, '/category',
                            arguments: {'label': 'Others', 'tasks': allTasks});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (allTasks.isEmpty)
                  const Center(child: Text('No tasks yet. Tap + to create one.'))
                else
                  ...allTasks.map((task) => GestureDetector(
                    onTap: () {
                      print('Navigating to /task_detail with: ' + (task != null ? task.title : 'null'));
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
                        await TaskService.updateTaskStatus(task.id, val);
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
  final int count;
  final String label;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.color,
    required this.icon,
    required this.count,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$count', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(label, style: const TextStyle(fontSize: 14)),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(value: isDone, onChanged: (val) {
                if (val != null) onDoneChanged(val);
              }),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(tag, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
