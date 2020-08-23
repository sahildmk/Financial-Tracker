import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

// part 'shiftCard.g.dart';

TextStyle fontStyle = GoogleFonts.hammersmithOne(
  color: Colors.black87,
  fontWeight: FontWeight.normal,
  fontSize: 16
);

// @HiveType(typeId: 2)
class ShiftCard extends StatelessWidget{
  // @HiveField(0)
  final String date;
  // @HiveField(1)
  final String start;
  // @HiveField(2)
  final String end;
  // @HiveField(3)
  final String length;

  ShiftCard(this.date, this.start, this.end, this.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          shadowColor: Colors.white,
          color: Colors.white38,
          child: InkWell(
            splashColor: Colors.black.withAlpha(30),
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: this.date,
                            style: GoogleFonts.hammersmithOne(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            )
                          ),
                        ),
                      ],  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: "Start: " + this.start,
                                style: fontStyle
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: "End: " + this.end,
                                style: fontStyle
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: "Length: " + this.length,
                            style: fontStyle
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}