import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> addTask(TaskModel task) async {
    final doc = _firestore.collection('tasks').doc(task.id);
    await doc.set({
      'id': task.id,
      'title': task.title,
      'tag': task.tag,
      'date': task.date,
      'subtasks': task.subtasks ?? [],
      'isDone': task.isDone,
      'createdBy': task.createdBy,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

  static Future<void> updateTaskStatus(String taskId, bool isDone) async {
    await _firestore.collection('tasks').doc(taskId).update({'isDone': isDone});
  }

  static Future<void> updateTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).update({
      'title': task.title,
      'tag': task.tag,
      'date': task.date,
      'subtasks': task.subtasks ?? [],
      'isDone': task.isDone,
    });
  }
}
