import 'package:flutter/material.dart';
import './Components/BottomNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}
