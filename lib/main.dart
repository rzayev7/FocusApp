import 'package:flutter/material.dart';
import 'package:focus_app_project/screens/home_screen.dart';
import 'package:focus_app_project/screens/login_screen.dart';
import 'package:focus_app_project/screens/register_screen.dart';
import 'package:focus_app_project/screens/features_screen.dart';
import 'package:focus_app_project/screens/list_screen.dart';
import 'package:focus_app_project/utils/app_colors.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/features': (context) => const FeaturesScreen(),
        '/list': (context) => const ListScreen(),
      },
    );
  }
}
