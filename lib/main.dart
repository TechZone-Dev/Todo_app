import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_login/screens/home_page.dart';
import 'package:todo_login/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs=await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn')?? false;

  runApp(
      MyApp(isLoggedIn: isLoggedIn));
}
class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key,required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: isLoggedIn ? HomePage():LoginScreen(),
        )

    );

  }
}
