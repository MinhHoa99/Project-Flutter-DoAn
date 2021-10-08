import 'package:doan_flutter/currency_conversion/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyConversionPage extends StatefulWidget {
  static String routeName = "/currency_conversion_form";
  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
