import 'dart:async';

import 'package:doan_flutter/electronic_money/components/electronic_money_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String timeString;
  @override
  void initState() {
    timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);

    if (mounted) {
      setState(() {
        timeString = formattedDateTime;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[300],
        title: new Text(
          "Tiền điện tử",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: null,
              child: Text(
                timeString,
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: ElectronicMoneyForm(),
    );
  }
}
