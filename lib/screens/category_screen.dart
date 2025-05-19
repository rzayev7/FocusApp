import 'package:flutter/material.dart';
import '../models/task_model.dart';

class CategoryTaskScreen extends StatelessWidget {
  final String categoryName;
  final List<TaskModel> allTasks;

  const CategoryTaskScreen({
    super.key,
    required this.categoryName,
    required this.allTasks,
  });

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> filteredTasks = allTasks
        .where((task) => task.tag.toLowerCase() == categoryName.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.folder, color: Colors.purple.shade400),
                    const SizedBox(width: 10),
                    Text(
                      '${filteredTasks.length} $categoryName',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const SizedBox(width: 40),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey.shade300,
                    child: const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey.shade300,
                    child: const Text('Task', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return _TaskRow(task: task);
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_task');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final TaskModel task;

  const _TaskRow({required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Navigating to /task_detail from category with: ' + (task != null ? task.title : 'null'));
        Navigator.pushNamed(
          context,
          '/task_detail',
          arguments: task,
        );
      },
      child: Container(
        color: Colors.grey.shade100,
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Checkbox(value: task.isDone, onChanged: (_) {}),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.date, style: const TextStyle(fontSize: 14)),
                    Text(task.tag.toUpperCase(),
                        style: const TextStyle(fontSize: 10, color: Colors.blue)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                task.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: task.isDone ? Colors.red : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}