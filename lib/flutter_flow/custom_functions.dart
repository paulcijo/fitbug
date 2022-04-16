import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

int getTodaysCounts(List<LogsRecord> logsForTheDay) {
  // Add your function code here!
  var total = 0;
  for (var i = 0; i < logsForTheDay.length; i++) {
    total += logsForTheDay[i].repCount;
  }
  return total;
}

DateTime getTodaysTimestamp() {
  // get todays timestamp
  DateTime today = DateTime.now();
  today = DateTime(today.year, today.month, today.day);

  return today;
}
