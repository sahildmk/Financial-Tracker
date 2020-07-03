import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
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
                            text: "Name: " + this.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
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
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
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
                            text: "Next Shift: " + this.nextShift,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            )
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