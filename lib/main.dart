import 'package:flutter/material.dart';
import 'package:shift_tracker/alertDialogs.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'jobCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'job.dart';

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
  JobCard newJob = new JobCard("JB HI-FI", "03/07/20", "04/07/20");

  addJob() {
    jobs.add(newJob);
    print(jobs.length);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarSize),
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                color: Colors.black87,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(phoneWidth / 18, appBarSize / 2.2, 0, 0),
                child: Text(
                  "Jobs",
                  style: GoogleFonts.hammersmithOne(fontSize: 50, color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ),
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
      bottomNavigationBar: TitledBottomNavigationBar(
        enableShadow: false,
        indicatorColor: Colors.black87,
        currentIndex: 0,
        onTap: (index) {
          print("Selected Index: $index");
        },
        items: [
          TitledNavigationBarItem(
            title: Text(
              'Home', 
              style: GoogleFonts.hammersmithOne(
                color: Colors.black, 
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ), 
            icon: Icons.home
          ),
          TitledNavigationBarItem(
            title: Text(
              'Search',
              style: GoogleFonts.hammersmithOne(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ), 
            icon: Icons.search
          ),
        ],
        reverse: true,
      ),
      floatingActionButton: FloatingActionButton( 
        onPressed: () {setState(() {
          addJob();
        });},
        backgroundColor: Colors.black87,
        child: Icon(Icons.add, size: 35),
      ),
    );
  }
}
