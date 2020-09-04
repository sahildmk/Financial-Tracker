import 'package:flutter/material.dart';
import 'package:shift_tracker/Classes/job.dart';
import 'package:shift_tracker/Custom_Widgets/alertDialogs.dart';
import '../Custom_Widgets/CustomWidgets.dart';

class JobScreen extends StatefulWidget {
  final Job job;
  JobScreen(this.job);
  @override
  _JobScreenState createState() => _JobScreenState(job);
}

class _JobScreenState extends State<JobScreen> {
  Job job;
  _JobScreenState(this.job);

  removeShift(int index, BuildContext context) {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  cancel(BuildContext context) {
    setState(() { 
      Navigator.of(context).pop();
    });
  }

  ListView _buildListView(double phoneHeight) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        final currJob = null;
        final currJobCard = currJob.getJobCard();
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            // deleteDialog(context, index, "Shift", removeShift, cancel);
          },
          child: currJobCard
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(height: phoneHeight / 100)
    );
  }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double appBarSize = phoneHeight / 10;
    return Scaffold(
      appBar: MyAppBar(phoneWidth, phoneHeight, appBarSize, job.getName()),
      body: Scaffold(
    
      ),
      bottomNavigationBar: myBottomNavBar(),
    );
  }
}