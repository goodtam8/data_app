import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location = " ";
  String time = " ";
  String flag = " ";
  String url = " ";
   late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var ur = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      var response = await http.get(ur);
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);

      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime=now.hour>6&&now.hour<20?true:false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error:$e');
      time = 'could not get time data';
    }
  }
}
