import 'package:flutter/material.dart';
import 'package:focus_app_project/models/task_model.dart';
import 'package:focus_app_project/screens/login_screen.dart';
import 'package:focus_app_project/screens/register_screen.dart';
import 'package:focus_app_project/utils/app_colors.dart';
import 'package:focus_app_project/screens/dashboard_screen.dart';
import 'package:focus_app_project/screens/category_screen.dart';
import 'package:focus_app_project/screens/task_detail_screen.dart';
import 'package:focus_app_project/screens/home_screen.dart';
import 'package:focus_app_project/screens/addTask_screen.dart';
import 'package:focus_app_project/screens/setting_screen.dart';
void main() {
  runApp(const FocusApp());
}

class FocusApp extends StatelessWidget {
  const FocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FocusApp',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'Poppins',
      ),
      routes: {
      '/': (context) => const HomeScreen(), // ✅ Add this!
      '/add_task': (context) => const AddTaskScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
      '/dashboard': (context) => const DashboardScreen(),
      '/settings': (context) => const SettingsScreen(),
      '/category': (context) {
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return CategoryTaskScreen(
          categoryName: args['label'],
          allTasks: args['tasks'],
        );
      },
      '/task_detail': (context) {
        final task = ModalRoute.of(context)!.settings.arguments as TaskModel;
        return TaskDetailScreen(task: task);
      },
},
);
}
}
