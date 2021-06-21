
import 'package:flutter/material.dart';

class Constants{
  static String myName = "";
  static String photoUrl = "";
  static String email = '';
 
  String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + 'h ago';
    }else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + 'm ago';
    }else if (diff.inSeconds > 0) {
      time = 'now';
    }else if (diff.inMilliseconds > 0) {
      time = 'now';
    }else if (diff.inMicroseconds > 0) {
      time = 'now';
    }else {
      time = 'now';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + 'd ago';
  } else if (diff.inDays > 6){
      time = (diff.inDays / 7).floor().toString() + 'w ago';
  }else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + 'm ago';
  }else if (diff.inDays > 365) {
    time = '${date.month}-${date.day}-${date.year}';
  }
  return time;
}
}
Color mainColor = Color(0xff0466C8);
Color textColor = Colors.white;
Color buttonColor = Color(0xffDA5151);
Color firstColor = Color(0xff002855);
Color secondColor = Color(0xff0D234B);
Color tilleColor = Color(0xff0077B6);



