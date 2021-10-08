import 'dart:async';
import 'package:doan_flutter/currency_conversion/currency_conversion_page.dart';
import 'package:doan_flutter/electronic_money/electronic_money_page.dart';
import 'package:doan_flutter/home/components/home_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  Body({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Color cl = Color(0xFFffff);
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
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white38,
          title: Text(
            "Giá vàng",
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
        drawer: Drawer(
          elevation: 20.0,
          child: Container(
            color: Colors.black54,
            child: ListView(
              children: <Widget>[
                ListTile(
                  tileColor: Colors.black54,
                  title: Text(
                    "Báo giá vàng",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                ListTile(
                  tileColor: Colors.black38,
                  trailing: Icon(
                    Icons.analytics_rounded,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Tiền điện tử",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ElectronicMoneyPage.routeName);
                  },
                ),
                SizedBox(height: 2),
                ListTile(
                    tileColor: Colors.black38,
                    trailing: Icon(
                      Icons.attach_money_rounded,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Quy đổi tiền tệ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CurrencyConversionPage.routeName);
                    }),
                SizedBox(height: 2),
                ListTile(
                  tileColor: Colors.black38,
                  title: Text(
                    "Close",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  trailing: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
        body: HomeForm());
  }
}
