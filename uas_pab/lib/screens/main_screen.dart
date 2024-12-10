import 'package:flutter/material.dart';
import 'package:uas_pab/screens/bookmark_screen.dart';
import 'package:uas_pab/screens/dashboard_screen.dart';
import 'package:uas_pab/screens/upload_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screenOptions = <Widget>[
    DashboardScreen(),
    UploadScreen(),
    BookmarkScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          //FIRST ITEM
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          //SECOND ITEM
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Upload'),
          //THIRD ITEM
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
