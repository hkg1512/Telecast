//System Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//UI
import 'package:telecast/ui/category_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telecast',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.black) ),
      home: CategoryScreen(),
    );
  }
}

