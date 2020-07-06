import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {  
  final double phoneWidth;
  final double phoneHeight;
  final double appBarSize;
  final String title;

  MyAppBar(this.phoneWidth, this.phoneHeight, this.appBarSize, this.title);

  @override
  Size get preferredSize => Size.fromHeight(appBarSize);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarSize),
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.black87,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(phoneWidth / 18, appBarSize / 1.9, 0, 0),
              child: Text(
                title,
                style: GoogleFonts.hammersmithOne(fontSize: 40, color: Colors.white),
              ),
            ),
          ],
        ),
      )
    );
  }
}

Widget myBottomNavBar() {
  return TitledBottomNavigationBar(
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
  );
}