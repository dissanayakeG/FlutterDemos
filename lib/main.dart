import 'package:demo_app/pages/home_layout.dart';
import 'package:demo_app/pages/recipes_page.dart';
import 'package:demo_app/pages/todo/todo_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter demo",
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeLayout(),
        "/todo-list": (context) => const TodoPage(),
        "/home": (context) => const RecipesPage(),
      },
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 10,
        titleTextStyle: TextStyle(
            fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
