import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String tag;
  final String date;
  final List<String>? subtasks;
  final bool isDone;
  final String createdBy;
  final Timestamp createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.tag,
    required this.date,
    this.subtasks,
    this.isDone = false,
    required this.createdBy,
    required this.createdAt,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    

    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      tag: data['tag'] ?? '',
      date: data['date'] ?? '',
      subtasks: List<String>.from(data['subtasks'] ?? []),
      isDone: data['isDone'] ?? false,
      createdBy: data['createdBy'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
