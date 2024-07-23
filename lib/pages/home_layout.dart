import 'package:demo_app/pages/recipes_page.dart';
import 'package:demo_app/pages/todo/todo_page.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StateHomeLayout();
  }
}

class _StateHomeLayout extends State<HomeLayout> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [RecipesPage(), TodoPage()];

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: "Recipes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Todos",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
