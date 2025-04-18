import 'package:flutter/material.dart';
import 'package:focus_app_project/models/task_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your full task list here
    final List<TaskModel> allTasks = [
      TaskModel(title: 'Drink 8 glasses of water', tag: 'Health', date: '13 Mar 2025'),
      TaskModel(title: 'Edit the PDF', tag: 'Work', date: '10 Sep 2025'),
      TaskModel(
        title: 'Write in a gratitude journal',
        tag: 'Mental Health',
        date: '12 Sep 2025',
        subtasks: ['Get a notebook', 'Follow the youtube tutorial'],
      ),
      TaskModel(title: 'Stretch everyday for 15 mins', tag: 'Health', date: '15 Mar 2025'),
      TaskModel(title: 'Do project', tag: 'Work', date: '14 Nov 2025'),
      TaskModel(title: 'Upload files', tag: 'Others', date: '11 Nov 2025', isDone: true),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: const [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '26 Dec',
                    style: TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Category Summary Grid
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
                      Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: {'label': 'Health', 'tasks': allTasks},
                      );
                    },
                  ),
                  _CategoryCard(
                    color: const Color(0xFFDFF7E8),
                    icon: Icons.check_box,
                    count: allTasks.where((t) => t.tag == 'Work').length,
                    label: 'Work',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: {'label': 'Work', 'tasks': allTasks},
                      );
                    },
                  ),
                  _CategoryCard(
                    color: const Color(0xFFF1D7F0),
                    icon: Icons.self_improvement,
                    count: allTasks.where((t) => t.tag == 'Mental Health').length,
                    label: 'Mental Health',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: {'label': 'Mental Health', 'tasks': allTasks},
                      );
                    },
                  ),
                  _CategoryCard(
                    color: const Color(0xFFE5E3E3),
                    icon: Icons.folder,
                    count: allTasks.where((t) => t.tag == 'Others').length,
                    label: 'Others',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: {'label': 'Others', 'tasks': allTasks},
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Sample Tasks Preview (static layout)
              const _TaskItem(title: 'Drink 8 glasses of water', tag: 'HEALTH'),
              const _TaskItem(title: 'Edit the PDF', tag: 'WORK'),
              const _TaskItem(
                title: 'Write in a gratitude journal',
                tag: 'MENTAL HEALTH',
                subtasks: [
                  'Get a notebook',
                  'Follow the youtube tutorial',
                ],
              ),
              const _TaskItem(title: 'Stretch everyday for 15 mins', tag: 'HEALTH'),
            ],
          ),
        ),
      ),
    );
  }
}

// Category Card Widget
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
                Text(
                  '$count',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Static Task Display Widget (dashboard preview)
class _TaskItem extends StatelessWidget {
  final String title;
  final String tag;
  final List<String>? subtasks;

  const _TaskItem({
    required this.title,
    required this.tag,
    this.subtasks,
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
              Checkbox(value: false, onChanged: (_) {}),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 16)),
              ),
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
              child: Text(
                tag,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (subtasks != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Column(
                children: subtasks!
                    .map(
                      (sub) => Row(
                        children: [
                          Checkbox(value: false, onChanged: (_) {}),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(sub),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
