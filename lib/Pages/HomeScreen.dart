import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  addJob() async {
    setState(() {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => JobForm()));
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

  List<Job> buildJobList(List<Map> jobRes) {
    List<Job> jobs = new List<Job>();
    if (jobRes != null) {
      for (Map m in jobRes) {
        jobs.add(new Job(m['name'], m['rateOfPay'],"Pay FREQ"));
      }
    }
    return jobs;
  }

  ListView _buildListView(double phoneHeight, List<Job> jobs) {
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: jobs.length,
        itemBuilder: (BuildContext context, int index) {
          final currJob = jobs[index];
          final currJobCard = currJob.getJobCard();
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                deleteDialog(context, index, "job", removeJob, cancel);
              },
              child: currJobCard);
        },
        separatorBuilder: (BuildContext context, int index) =>
            Container(height: phoneHeight / 100));
  }

  @override
  void initState() {
    super.initState();
    jobFuture = getJobs();
  }

  getJobs() async {
    final jobsRes = await DBProvider.db.getJobs();
    print(jobsRes);
    return jobsRes;
  }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double appBarSize = phoneHeight / 10;

    return Scaffold(
      appBar: MyAppBar(phoneWidth, phoneHeight, appBarSize, "Jobs"),
      body: FutureBuilder(
        future: jobFuture,
        builder: (BuildContext context, jobList) {
          if (jobList.connectionState == ConnectionState.done) {
            if (jobList.hasError) {
              print("jobList Error");
              print(jobList.error.toString());
            } else {
              List<Job> jobs = buildJobList(jobList.data);
              return _buildListView(phoneHeight, jobs);
            }
          }
          return Scaffold();
        },
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
