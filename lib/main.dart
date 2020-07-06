import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift_tracker/CustomWidgets.dart';
import 'package:shift_tracker/alertDialogs.dart';
import 'jobCard.dart';
import 'newJobForm.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Container(
      child: HomePage(),
    ),
  )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<JobCard> jobs = [];

  addJob() async {
    final newJob = await Navigator.push(
      context, 
      CupertinoPageRoute(builder: (context) => newJobForm())
    );
    // print(newJob);
    if (newJob != null) {
      setState(() {
        jobs.add(newJob.getJobCard());
      });
    }
  }

  removeJob(int index, BuildContext context) {
    setState(() {
      jobs.removeAt(index); 
      Navigator.of(context).pop();
    });
    print(jobs.length);
  }

  cancel(BuildContext context) {
    setState(() { 
      Navigator.of(context).pop();
    });
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
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: jobs.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              deleteDialog(context, index, "job", removeJob, cancel);
            },
            child: jobs[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(height: phoneHeight / 100)
      ),
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
