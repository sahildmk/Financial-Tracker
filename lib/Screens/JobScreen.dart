import 'package:flutter/material.dart';
import '../Custom_Widgets/CustomWidgets.dart';

class JobScreen extends StatefulWidget {
  final String name;
  JobScreen(this.name);
  @override
  _JobScreenState createState() => _JobScreenState(name);
}

class _JobScreenState extends State<JobScreen> {
  String name;
  _JobScreenState(this.name);
  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double appBarSize = phoneHeight / 10;
    return Scaffold(
      appBar: MyAppBar(phoneWidth, phoneHeight, appBarSize, name),
      body: Scaffold(
    
      ),
      bottomNavigationBar: myBottomNavBar(),
    );
  }
}