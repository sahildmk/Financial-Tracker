import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shift_tracker/Classes/job.dart';
import 'package:validators/sanitizers.dart';
import '../Custom_Widgets/CustomWidgets.dart';
import 'package:validators/validators.dart';
import '../utils/Database.dart';

class newJobForm extends StatefulWidget {
  @override
  _newJobFormState createState() => _newJobFormState();
}

class _newJobFormState extends State<newJobForm> {
  TextStyle titleStyle = GoogleFonts.hammersmithOne(
      color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25);

  TextStyle inputStyle = GoogleFonts.hammersmithOne(
      color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15);

  TextStyle errorStyle = GoogleFonts.hammersmithOne(
      color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15);

  String name;
  double rateOfPay;
  String payFreq;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildName() {
    return TextFormField(
      autofocus: false,
      style: inputStyle,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Job Name",
          labelStyle: titleStyle,
          errorStyle: errorStyle,
          hintText: "E.g. McDonalds",
          border: OutlineInputBorder(
              borderRadius: (BorderRadius.circular(5.0)),
              borderSide:
                  BorderSide(color: Colors.amber, style: BorderStyle.solid))),
      validator: (String value) {
        value = value.trim();
        if (value.isEmpty) {
          return 'Name is Required';
        }
      },
      onSaved: (String value) {
        this.name = value;
      },
    );
  }

  Widget buildRateOfPay() {
    return TextFormField(
      autofocus: false,
      style: inputStyle,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          prefixText: "\$ ",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Rate of Pay (Per Hour)",
          labelStyle: titleStyle,
          errorStyle: errorStyle,
          // hintText: "E.g \$25.71",
          border: OutlineInputBorder(
              borderRadius: (BorderRadius.circular(5.0)),
              borderSide:
                  BorderSide(color: Colors.amber, style: BorderStyle.solid))),
      validator: (String value) {
        value = value.trim();
        if (value.isEmpty) {
          return 'Rate of Pay is Required';
        } else if (!isFloat(value)) {
          return 'Rate of Pay must be a numeric value';
        } else if (value.contains(" ")) {
          return 'Rate of Pay cannot contain any spaces';
        }
      },
      onSaved: (String value) {
        this.rateOfPay = toDouble(value);
      },
    );
  }

  Widget buildPayFreq() {
    List<String> items = [
      'Daily',
      'Weekly',
      'Fortnightly',
      'Monthly',
      'Quaterly',
      'Yearly'
    ];

    return DropdownButtonFormField(
      autofocus: false,
      style: inputStyle,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Pay Frequency",
          labelStyle: titleStyle,
          errorStyle: errorStyle,
          border: OutlineInputBorder(
              borderRadius: (BorderRadius.circular(5.0)),
              borderSide:
                  BorderSide(color: Colors.amber, style: BorderStyle.solid))),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        this.payFreq = value;
      },
      onSaved: (newValue) {
        this.payFreq = newValue;
      },
      validator: (String value) {
        if (isNull(value)) {
          return 'Please choose a pay frequency';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double appBarSize = phoneHeight / 10;

    return Scaffold(
      appBar: MyAppBar(phoneWidth, phoneHeight, appBarSize, "New Job"),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildName(),
              buildRateOfPay(),
              buildPayFreq(),
              RaisedButton(
                padding: EdgeInsets.all(13),
                child: Text(
                  "Confirm",
                  style: titleStyle,
                ),
                onPressed: () async {
                  if (!formKey.currentState.validate()) {
                    return;
                  }

                  formKey.currentState.save();
                  Job newJob = new Job(this.name, this.rateOfPay, this.payFreq);
                  await DBProvider.db.newJob(newJob);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
