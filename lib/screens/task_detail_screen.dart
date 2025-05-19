import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'package:focus_app_project/services/task_service.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _titleController;
  late String _selectedCategory;
  late DateTime _selectedDate;
  bool _isSaving = false;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _selectedCategory = widget.task.tag;
    _selectedDate = DateFormat('dd MMM yyyy').parse(widget.task.date);
    _isDone = widget.task.isDone;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _saveTask() async {
    setState(() => _isSaving = true);
    final updatedTask = TaskModel(
      id: widget.task.id,
      title: _titleController.text.trim(),
      tag: _selectedCategory,
      date: DateFormat('dd MMM yyyy').format(_selectedDate),
      subtasks: widget.task.subtasks,
      isDone: _isDone,
      createdBy: widget.task.createdBy,
      createdAt: widget.task.createdAt,
    );
    await TaskService.updateTask(updatedTask);
    setState(() => _isSaving = false);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _deleteTask() async {
    setState(() => _isSaving = true);
    try {
      await TaskService.deleteTask(widget.task.id);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete task: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _isSaving ? null : _deleteTask,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _isDone,
                    onChanged: _isSaving ? null : (val) {
                      if (val != null) setState(() => _isDone = val);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(_isDone ? 'Task is done' : 'Task is not done'),
                ],
              ),
              const Text('Description:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFEFEF),
                  border: OutlineInputBorder(),
                ),
                enabled: !_isSaving,
              ),
              const SizedBox(height: 24),
              const Text('Date', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _isSaving ? null : _pickDate,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(DateFormat('dd MMM yyyy').format(_selectedDate), style: const TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Category', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: ['General', 'Health', 'Work', 'Mental Health', 'Others']
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: _isSaving ? null : (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE8E9FF),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isSaving ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
