import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GoldChartForm extends StatefulWidget {
  final String goldTypeChart;
  GoldChartForm({this.goldTypeChart});

  @override
  _GoldChartFormState createState() => _GoldChartFormState();
}

class _GoldChartFormState extends State<GoldChartForm> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  String titleGoldType;

  List<GoldChart> listDataChart = [];

  Future<List<GoldChart>> getDataChart(int countDays) async {
    String url = 'https://vapi.vnappmob.com/api/v2/gold/pnj';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjU2MzE0NzksImlhdCI6MTYyNDMzNTQ3OSwic2NvcGUiOiJnb2xkIiwicGVybWlzc2lvbiI6MH0.UDQolfXSj6cNMtC7PfWsXYL8W7-dQMX55PbKQtOS02A',
    };

    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int today = DateTime.now().day;

    int timestampTo =
        DateTime(year, month, today, 7, 0, 0).millisecondsSinceEpoch ~/ 1000;
    int timestampFrom = 0;

    if (countDays == 30) {
      timestampFrom =
          DateTime(year, month, 1, 7, 0, 0).millisecondsSinceEpoch ~/ 1000;
    } else {
      timestampFrom = timestampTo - (86400 * countDays);
    }

    print('Today: $timestampTo');
    print('Yeterday: $timestampFrom');

    String params = '?date_from=$timestampFrom&date_to=$timestampTo';
    final response = await http.get(url + params, headers: header);

    if (response.statusCode == 200) {
      var listGold = json.decode(response.body)['results'] as List<dynamic>;
      print(listGold);
      List<GoldChart> results = listGold
          .map((itemGold) => GoldChart.fromJson(itemGold, widget.goldTypeChart))
          .toList();

      setState(() {
        listDataChart = results;
      });

      return results;
    } else {
      throw Exception('Request API error.');
    }
  }

  @override
  void initState() {
    super.initState();

    getDataChart(30);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.goldTypeChart) {
      case 'NT10K':
        titleGoldType = 'Vàng nữ trang 10K';
        break;
      case 'NT14K':
        titleGoldType = 'Vàng nữ trang 14K';
        break;
      case 'NT18K':
        titleGoldType = 'Vàng nữ trang 18K';
        break;
      case 'NT24K':
        titleGoldType = 'Vàng nữ trang 24K';
        break;
      case 'NHAN24K':
        titleGoldType = 'Vàng nhẫn 24K';
        break;
      default:
    }

    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/PNJ.png',
              width: 300,
              height: 200,
            ),
            Text(
              titleGoldType,
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  color: Colors.yellow.shade600,
                  fontSize: 25,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 480,
              child: SfCartesianChart(
                series: <ChartSeries>[
                  LineSeries<GoldChart, dynamic>(
                    dataSource: listDataChart,
                    xValueMapper: (GoldChart goldChart, _) => goldChart.date,
                    yValueMapper: (GoldChart goldChart, _) =>
                        goldChart.buyPrice / 1000000,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
                primaryXAxis:
                    NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                primaryYAxis: NumericAxis(
                    labelFormat: '{value}Tr',
                    numberFormat: NumberFormat.simpleCurrency(
                        decimalDigits: 2, locale: 'vi_VN')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoldChart {
  double buyPrice;
  double sellPrice;
  int date;

  GoldChart({this.buyPrice, this.sellPrice, this.date});

  GoldChart.fromJson(Map<String, dynamic> json, String typeGold) {
    switch (typeGold) {
      case 'NT10K':
        buyPrice = json['buy_nt_10k'];
        sellPrice = json['sell_nt_10k'];
        date = DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['datetime']) * 1000)
            .day;
        break;
      case 'NT14K':
        buyPrice = json['buy_nt_14k'];
        sellPrice = json['sell_nt_14k'];
        date = DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['datetime']) * 1000)
            .day;
        break;
      case 'NT18K':
        buyPrice = json['buy_nt_18k'];
        sellPrice = json['sell_nt_18k'];
        date = DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['datetime']) * 1000)
            .day;
        break;
      case 'NT24K':
        buyPrice = json['buy_nt_24k'];
        sellPrice = json['sell_nt_24k'];
        date = DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['datetime']) * 1000)
            .day;
        break;
      case 'NHAN24K':
        buyPrice = json['buy_nhan_24k'];
        sellPrice = json['sell_nhan_24k'];
        date = DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['datetime']) * 1000)
            .day;
        break;
      default:
        break;
    }
  }
}
