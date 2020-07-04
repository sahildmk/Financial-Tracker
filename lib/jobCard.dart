import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle fontStyle = GoogleFonts.cabin(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700
                            );

class JobCard extends StatelessWidget{
  final String name;
  final String lastShift;
  final String nextShift;

  JobCard(this.name, this.lastShift, this.nextShift);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          color: Color.fromRGBO(230, 230, 230, 100),
          child: InkWell(
            splashColor: Colors.black.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                    child: Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: this.name,
                            style: GoogleFonts.cabin(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            )
                          ),
                        ),
                      ],  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                    child: Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: "Last Shift: " + this.lastShift,
                            style: fontStyle
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                    child: Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: "Next Shift: " + this.nextShift,
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