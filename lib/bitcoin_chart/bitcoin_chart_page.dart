import 'package:doan_flutter/bitcoin_chart/components/body.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

class BitcoinchartPage extends StatefulWidget {
  static String routeName = "/bitcoin_chart_page";
  @override
  _BitcoinchartPageState createState() => _BitcoinchartPageState();
}

class _BitcoinchartPageState extends State<BitcoinchartPage> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
