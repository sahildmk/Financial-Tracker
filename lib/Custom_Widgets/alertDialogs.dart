import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> deleteDialog(BuildContext context, int dbID, int listID, String item, 
  Function delFunc, Function cancelFunc) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Delete $item',
          style: GoogleFonts.hammersmithOne(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Are you sure you want to delete this $item? You will lose all other information related to it.',
                style: GoogleFonts.hammersmithOne(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Confirm',
              style: GoogleFonts.hammersmithOne(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () {
              delFunc(dbID, listID, context);
            },
          ),
          FlatButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.hammersmithOne(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () {
              cancelFunc(context);
            },
          ),
        ],
      );
    },
  );
}
