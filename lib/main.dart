import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'jobCard.dart';

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
    JobCard newJob = new JobCard("JB HI-FI", "03/07/20", "04/07/20");
    for (int i = 0; i < 10; i++) {
      jobs.add(newJob);
    }
  }

  @override
  void initState() {
    addJob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text("Jobs"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: jobs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(child: jobs[index]);
                },
                separatorBuilder: (BuildContext context, int index) => const Divider()
              ),
            )
          ],
        )
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          print("Selected Index: $index");
        },
        items: [
           TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
           TitledNavigationBarItem(title: Text('Search'), icon: Icons.search),
        ],
        reverse: true,
      ),
    );
  }
}
