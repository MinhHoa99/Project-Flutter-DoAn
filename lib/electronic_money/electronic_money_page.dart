import 'package:doan_flutter/electronic_money/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElectronicMoneyPage extends StatefulWidget {
  static String routeName = "/electronic_money";

  @override
  _ElectronicMoneyPageState createState() => _ElectronicMoneyPageState();
}

class _ElectronicMoneyPageState extends State<ElectronicMoneyPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
