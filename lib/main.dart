import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift_tracker/CustomWidgets.dart';
import 'package:shift_tracker/alertDialogs.dart';
import 'jobCard.dart';
import 'newJobForm.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'job.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(JobAdapter());
  Hive.registerAdapter(JobCardAdapter());
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
        child: FutureBuilder(
          future: Hive.openBox('jobs'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print("Snapshot Error");
                print(snapshot.error.toString());
              } else {
                return HomePage();
              }
            }
            return Scaffold();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  addJob() async {
    setState(() {
      Navigator.push(
        context, 
        CupertinoPageRoute(builder: (context) => newJobForm())
      );
    });
    // print(newJob);
    // if (newJob != null) {
    //   setState(() {
    //     jobs.add(newJob.getJobCard());
    //   });
    // }
  }

  removeJob(int index, BuildContext context) {
    final jobsBox = Hive.box('jobs');
    setState(() {
      jobsBox.deleteAt(index);
      Navigator.of(context).pop();
    });
    print(jobsBox.length);
  }

  cancel(BuildContext context) {
    setState(() { 
      Navigator.of(context).pop();
    });
  }

  ListView _buildListView(double phoneHeight) {
    final jobsBox = Hive.box('jobs');
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: jobsBox.length,
      itemBuilder: (BuildContext context, int index) {
        final currJob = jobsBox.getAt(index) as Job;
        final currJobCard = currJob.getJobCard();
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            deleteDialog(context, index, "job", removeJob, cancel);
          },
          child: currJobCard
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(height: phoneHeight / 100)
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double appBarSize = phoneHeight / 10;

    return Scaffold(
      appBar: MyAppBar(phoneWidth, phoneHeight, appBarSize, "Jobs"),
      body: _buildListView(phoneHeight),
      bottomNavigationBar: myBottomNavBar(),
      floatingActionButton: FloatingActionButton( 
        onPressed: () {
          setState(() {
            addJob();
          });
        },
        backgroundColor: Colors.black87,
        child: Icon(Icons.add, size: (phoneHeight * phoneWidth) / 8000),
      ),
    );
  }

  
}
