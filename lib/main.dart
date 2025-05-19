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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    print('Caught Flutter error: ${details.exception}');
    print('Stack trace: ${details.stack}');
  };
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const FocusApp(),
    ),
  );
}

class FocusApp extends StatelessWidget {
  const FocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FocusApp',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add_task': (context) => const AddTaskScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/task_detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          print('Route /task_detail called with args: ' + args.toString());
          if (args == null || args is! TaskModel) {
            return const Scaffold(body: Center(child: Text('No task provided')));
          }
          return TaskDetailScreen(task: args as TaskModel);
        },
      },
      onGenerateRoute: (settings) {
        print('onGenerateRoute called for: \\${settings.name}');
        return null; // Let onUnknownRoute handle it
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Unknown route')),
        ),
      ),
    );
  }
}
