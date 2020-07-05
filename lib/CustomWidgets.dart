import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              padding: EdgeInsets.fromLTRB(phoneWidth / 18, appBarSize / 2.2, 0, 0),
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