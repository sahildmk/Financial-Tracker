import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shift_tracker/Classes/job.dart';
import 'package:shift_tracker/Custom_Widgets/CustomWidgets.dart';
import 'package:shift_tracker/Custom_Widgets/alertDialogs.dart';

import 'newJobForm.dart';

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