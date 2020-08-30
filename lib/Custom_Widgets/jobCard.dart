import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shift_tracker/Classes/job.dart';
import '../Pages/JobScreen.dart';

TextStyle fontStyle = GoogleFonts.hammersmithOne(
  color: Colors.black87,
  fontWeight: FontWeight.normal,
  fontSize: 16
);

class JobCard extends StatelessWidget{
  final String name;
  final String rateOfPay;
  final String payFreq;
  final Job job;

  JobCard(this.name, this.rateOfPay, this.payFreq, this.job);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          shadowColor: Colors.white,
          color: Colors.white38,
          child: InkWell(
            splashColor: Colors.black.withAlpha(30),
            onTap: () {
              print('Card tapped.');
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => JobScreen(job))
              );
            },
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
                            text: this.name,
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
                        RichText(
                          text: TextSpan(
                            text: "Rate of Pay: \$" + this.rateOfPay,
                            style: fontStyle
                          ),
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
                            text: "Pay frequency: " + this.payFreq,
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