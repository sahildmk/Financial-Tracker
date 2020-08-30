import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift_tracker/utils/Database.dart';
import 'Custom_Widgets/jobCard.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'Classes/job.dart';
import 'Pages/HomeScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDirectory.path);
  // Hive.registerAdapter(JobCardAdapter());
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
