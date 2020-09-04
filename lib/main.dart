import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift_tracker/utils/Database.dart';
import 'Pages/HomeScreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    DBProvider.db.closeDB();
    super.dispose();
  }
}
