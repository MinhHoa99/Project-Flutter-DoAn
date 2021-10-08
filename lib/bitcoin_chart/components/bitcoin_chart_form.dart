import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BitcoinchartForm extends StatefulWidget {
  final String idCoin;
  BitcoinchartForm({this.idCoin});

  @override
  _BitcoinchartFormState createState() => _BitcoinchartFormState();
}

class _BitcoinchartFormState extends State<BitcoinchartForm> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<CoinChart> listCoinChart = [];

  Future<List<CoinChart>> getDataChart(String id) async {
    String url =
        'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=vnd&days=30&interval=daily';

    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      var listCoins = json.decode(response.body)['prices'];

      List<CoinChart> results = [];
      for (var item in listCoins) {
        results.add(new CoinChart(
            price: item[1],
            date: DateTime.fromMillisecondsSinceEpoch(item[0]).day));
      }

      setState(() {
        listCoinChart = results;
        listCoinChart.sort((a, b) => a.date.compareTo(b.date));
      });

      for (var item in listCoinChart) {
        print('Price: ${item.price}, Date: ${item.date}');
      }

      return listCoinChart;
    } else {
      throw Exception('Request API error.');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataChart(widget.idCoin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Color(0xFF274259)),
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 70.0,
            ),
            SizedBox(
              child: Text(
                'Biểu đồ tiền điện tử',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 25,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 480,
              child: SfCartesianChart(
                series: <ChartSeries>[
                  LineSeries<CoinChart, dynamic>(
                    dataSource: listCoinChart,
                    xValueMapper: (CoinChart coinChart, _) => coinChart.date,
                    yValueMapper: (CoinChart coinChart, _) =>
                        coinChart.price / 1000000000,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
                primaryXAxis:
                    NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                primaryYAxis: NumericAxis(
                    labelFormat: '{value}Tỷ',
                    labelStyle: TextStyle(color: Colors.white),
                    numberFormat: NumberFormat.simpleCurrency(
                      decimalDigits: 2,
                      locale: 'vi_VN',
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoinChart {
  double price;
  int date;

  CoinChart({this.price, this.date});
}
