import 'package:flutter/material.dart';
import 'package:gorest_demo/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoRest Demo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
