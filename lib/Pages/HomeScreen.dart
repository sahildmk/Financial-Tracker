import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift_tracker/Classes/job.dart';
import 'package:shift_tracker/Custom_Widgets/CustomWidgets.dart';
import 'package:shift_tracker/Custom_Widgets/alertDialogs.dart';
import 'package:shift_tracker/utils/Database.dart';

import '../Forms/JobForm.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future jobFuture;
  List<Job> jobList;
  StreamController _streamController;
  Stream _stream;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    jobFuture = getJobs();
  }

  addJob() async {
    _streamController.add("waiting");
    final newJob = await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => JobForm()));

    if (newJob != Null) {
      setState(() {
        jobList.add(newJob);
      });
      _streamController.add("add job");
    }
  }

  removeJob(int jobID, int listIndex, BuildContext context) {
    setState(() {
      jobList.removeAt(listIndex);
      DBProvider.db.removeJob(jobID);
      Navigator.of(context).pop();
    });
    _streamController.add("del job");
  }

  cancel(BuildContext context) {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  List<Job> buildJobList(List<Map> jobRes) {
    List<Job> jobs = new List<Job>();
    if (jobRes != null) {
      for (Map m in jobRes) {
        jobs.add(new Job(m['jobID'], m['name'], m['rateOfPay'], "Pay FREQ"));
      }
      _streamController.add("init jobs");
    } else {
      _streamController.add(null);
    }
    return jobs;
  }

  ListView _buildListView(double phoneHeight) {
    return new ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: jobList.length,
        itemBuilder: (BuildContext context, int index) {
          final currJob = jobList[index];
          final currJobCard = currJob.getJobCard();
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) async {
                await deleteDialog(
                    context, currJob.getID(), index, "job", removeJob, cancel);
              },
              child: currJobCard);
        },
        separatorBuilder: (BuildContext context, int index) =>
            Container(height: phoneHeight / 100));
  }

  getJobs() async {
    final jobsRes = await DBProvider.db.getJobs();
    jobList = buildJobList(jobsRes);
    return jobsRes;
  }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double appBarSize = phoneHeight / 10;

    return Scaffold(
      appBar: MyAppBar(phoneWidth, phoneHeight, appBarSize, "Jobs"),
      body: StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Scaffold();
          }

          if (snapshot.data == "waiting") {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return _buildListView(phoneHeight);
        },
      ),
      bottomNavigationBar: myBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addJob(),
        backgroundColor: Colors.black87,
        child: Icon(Icons.add, size: (phoneHeight * phoneWidth) / 8000),
      ),
    );
  }
}
