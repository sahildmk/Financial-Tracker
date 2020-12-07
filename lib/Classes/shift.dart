import 'package:flutter/material.dart';
import 'package:shift_tracker/Custom_Widgets/shiftCard.dart';

import 'job.dart';

class Shift {
  TimeOfDay _start;
  TimeOfDay _end;
  DateTime _date;
  Job _job;
  String _comments;
  double _length;
  double _netPay;
  double _grossPay;
  ShiftCard _shiftCard;
  int _shiftId;

  Shift(
      TimeOfDay start, TimeOfDay end, DateTime date, Job job, String comments) {
    this._start = start;
    this._end = end;
    this._date = date;
    this._job = job;
    this._comments = comments;
    this._length = _calculateLength(start, end);
    this._grossPay = this._length * this._job.getRateOfPay();
    this._shiftCard = new ShiftCard(
        date.toString(), start.toString(), end.toString(), length.toString());
  }

  double _calculateLength(TimeOfDay start, TimeOfDay end) =>
      _toDouble(end) - _toDouble(start);

  double _toDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  TimeOfDay get startTime => _start;
  set setStartTime(TimeOfDay start) {
    _start = start;
  }

  TimeOfDay get endTime => _end;
  set setEndTime(TimeOfDay end) {
    _end = end;
  }

  DateTime get date => _date;
  set setDate(DateTime date) {
    _date = date;
  }

  Job get jobID => _job;
  set setJob(Job job) {
    _job = job;
  }

  String get comments => _comments;
  set setComment(String comment) {
    _comments = comment;
  }

  double get grossPay => _grossPay;
  set setGrossPay(double grossPay) {
    _grossPay = grossPay;
  }

  double get netPay => _netPay;
  set setNetPay(double netPay) {
    _netPay = netPay;
  }

  double get length => _length;

  ShiftCard get shiftCard => _shiftCard;

  int get shiftId => _shiftId;
}
