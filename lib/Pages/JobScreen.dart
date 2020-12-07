import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift_tracker/Classes/job.dart';
import 'package:shift_tracker/Classes/shift.dart';
import 'package:shift_tracker/Custom_Widgets/CustomWidgets.dart';
import 'package:shift_tracker/Custom_Widgets/alertDialogs.dart';
// import 'package:shift_tracker/utils/Database.dart';
// import '../Forms/ShiftForm.dart';

class JobScreen extends StatefulWidget {
  Job job;
  JobScreen(this.job);
  @override
  _JobScreenState createState() => _JobScreenState(job);
}

class _JobScreenState extends State<JobScreen> {
  Job job;
  _JobScreenState(this.job);
  Future shiftFuture;
  List<Shift> shiftList;
  StreamController _streamController;
  Stream _stream;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    // shiftFuture = getshifts();
  }

  // addShift() async {
  //   _streamController.add("waiting");
  //   final newshift = await Navigator.push(
  //       context, CupertinoPageRoute(builder: (context) => ShiftForm()));

  //   if (newshift != Null) {
  //     setState(() {
  //       shiftList.add(newshift);
  //     });
  //     _streamController.add("add shift");
  //   }
  // }

  removeshift(int shiftID, int listIndex, BuildContext context) {
    setState(() {
      shiftList.removeAt(listIndex);
      // DBProvider.db.removeShift(shiftID);
      Navigator.of(context).pop();
    });
    _streamController.add("del shift");
  }

  cancel(BuildContext context) {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  List<Shift> buildshiftList(List<Map> shiftRes) {
    List<Shift> shifts = new List<Shift>();
    if (shiftRes != null) {
      for (Map m in shiftRes) {
        // shifts.add(new shift(m['shiftID'], m['name'], m['rateOfPay'], "Pay FREQ"));
      }
      _streamController.add("init shifts");
    } else {
      _streamController.add(null);
    }
    return shifts;
  }

  ListView _buildListView(double phoneHeight) {
    return new ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: shiftList.length,
        itemBuilder: (BuildContext context, int index) {
          final currshift = shiftList[index];
          final currshiftCard = currshift.shiftCard;
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) async {
                await deleteDialog(context, currshift.shiftId, index, "shift",
                    removeshift, cancel);
              },
              child: currshiftCard);
        },
        separatorBuilder: (BuildContext context, int index) =>
            Container(height: phoneHeight / 100));
  }

  // getshifts() async {
  //   final shiftsRes = await DBProvider.db.getShifts();
  //   shiftList = buildshiftList(shiftsRes);
  //   return shiftsRes;
  // }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double appBarSize = phoneHeight / 10;

    return Scaffold(
      appBar: MyAppBar(phoneWidth, phoneHeight, appBarSize, "shifts"),
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
        onPressed: () => {},
        backgroundColor: Colors.black87,
        child: Icon(Icons.add, size: (phoneHeight * phoneWidth) / 8000),
      ),
    );
  }
}
