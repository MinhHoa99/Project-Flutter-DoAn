import 'package:doan_flutter/bitcoin_chart/bitcoin_chart_page.dart';
import 'package:doan_flutter/currency_conversion/currency_conversion_page.dart';
import 'package:doan_flutter/electronic_money/electronic_money_page.dart';
import 'package:doan_flutter/gold_chart/gold_chart_page.dart';
import 'package:doan_flutter/home/components/home_form.dart';
import 'package:doan_flutter/home/home_page.dart';
import 'package:doan_flutter/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'home/home_page.dart';

final Map<String, WidgetBuilder> routes ={
  SplashPage.routeName: (context) => SplashPage(),
  HomePage.routeName: (context) => HomePage(),
  HomeForm.routeName: (context) => HomeForm(),
  CurrencyConversionPage.routeName:(context) => CurrencyConversionPage(),
  ElectronicMoneyPage.routeName:(context) => ElectronicMoneyPage(),
  BitcoinchartPage.routeName:(context) => BitcoinchartPage(),
  GoldChartPage.routeName:(context) => GoldChartPage(),
};