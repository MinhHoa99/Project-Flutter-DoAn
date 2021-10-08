import 'package:doan_flutter/gold_chart/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoldChartPage extends StatefulWidget {
  static String routeName = "/gold_chart_page";

  final String goldData;
  GoldChartPage({this.goldData});

  @override
  _GoldChartPageState createState() => _GoldChartPageState();
}

class _GoldChartPageState extends State<GoldChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
