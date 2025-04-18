class TaskModel {
  final String title;
  final String tag; // Category: Health, Work, etc.
  final String date;
  final bool isDone;
  final List<String>? subtasks;

  TaskModel({
    required this.title,
    required this.tag,
    required this.date,
    this.isDone = false,
    this.subtasks,
  });
}
