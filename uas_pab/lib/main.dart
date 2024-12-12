import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_pab/screens/dashboard_screen.dart';
//import 'package:uas_pab/screens/home_screen.dart';
import 'package:uas_pab/screens/login_screen.dart';
//import 'package:uas_pab/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MainApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: MainScreen(),
      //title: 'Login',
      //theme:
      //ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      home: isLoggedIn ? const DashboardScreen() : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        //'/home': (context) => const HomeScreen(),
      },
    );
  }
}
