import 'dart:convert';
import 'package:doan_flutter/gold_chart/components/gold_chart_form.dart';
import 'package:doan_flutter/models/Gold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeForm extends StatefulWidget {
  static String routeName = "/home_form";
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  Future<List<Gold>> fetchGoldPNJ() async {
    String url = 'https://vapi.vnappmob.com/api/v2/gold/pnj';
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjU2MzExMDYsImlhdCI6MTYyNDMzNTEwNiwic2NvcGUiOiJnb2xkIiwicGVybWlzc2lvbiI6MH0.on51G7776Ce0nCrosGXvZKmsoyDh6sHRsfxykibzz8Y',
    };

    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int today = DateTime.now().day;

    int timestampTo =
        DateTime(year, month, today, 7, 0, 0).millisecondsSinceEpoch ~/ 1000;
    int timestampFrom = timestampTo - (86400 * 3);

    String params = '?date_from=$timestampFrom&date_to=$timestampTo';

    print('Today: $timestampTo');
    print('Yeterday: $timestampFrom');

    final response = await http.get(url + params, headers: header);

    if (response.statusCode == 200) {
      var listGold = json.decode(response.body)['results'] as List<dynamic>;
      List<Gold> results =
          listGold.map((itemGold) => Gold.fromJson(itemGold)).toList();
      print('Length list: ${results.length}');
      return results;
    } else {
      throw Exception('Request API error.');
    }
  }

  Future<List<Gold>> fetchGoldData;

  @override
  void initState() {
    super.initState();

    fetchGoldData = fetchGoldPNJ();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder(
        future: fetchGoldData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.only(top: 15, left: 6, right: 6),
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('Loại vàng',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('Mua vào',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('Bán ra',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GoldChartForm(
                                    goldTypeChart: 'NT10K',
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Vàng nữ trang 10k',
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              )),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].buyNt10k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Raleway',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].buyNt10k -
                                            snapshot.data[0].buyNt10k),
                                        style: TextStyle(
                                          color: (snapshot.data[1].buyNt10k -
                                                      snapshot.data[0]
                                                          .sellNhan24k) >=
                                                  0
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                          fontFamily: 'Raleway',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].sellNt10k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].sellNt10k -
                                            snapshot.data[0].sellNt10k),
                                        style: TextStyle(
                                            color: (snapshot.data[1].sellNt10k -
                                                        snapshot.data[0]
                                                            .sellNt10k) >=
                                                    0
                                                ? Colors.green.shade600
                                                : Colors.red.shade600,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GoldChartForm(
                                    goldTypeChart: 'NT14K',
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Vàng nữ trang 14k',
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              )),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].buyNt14k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Raleway',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].buyNt14k -
                                            snapshot.data[0].buyNt14k),
                                        style: TextStyle(
                                          color: (snapshot.data[1].buyNt14k -
                                                      snapshot
                                                          .data[0].buyNt14k) >=
                                                  0
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                          fontFamily: 'Raleway',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].sellNt14k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].sellNt14k -
                                            snapshot.data[0].sellNt14k),
                                        style: TextStyle(
                                            color: (snapshot.data[1].sellNt14k -
                                                        snapshot.data[0]
                                                            .sellNt14k) >=
                                                    0
                                                ? Colors.green.shade600
                                                : Colors.red.shade600,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GoldChartForm(
                                    goldTypeChart: 'NT18K',
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                child: Column(
                                  children: [
                                    Text('Vàng nữ trang 18K',
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              )),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].buyNt18k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Raleway',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].buyNt18k -
                                            snapshot.data[0].buyNt18k),
                                        style: TextStyle(
                                          color: (snapshot.data[1].buyNt18k -
                                                      snapshot
                                                          .data[0].buyNt18k) >=
                                                  0
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                          fontFamily: 'Raleway',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].sellNt18k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].sellNt18k -
                                            snapshot.data[0].sellNt18k),
                                        style: TextStyle(
                                            color: (snapshot.data[1].sellNt18k -
                                                        snapshot.data[0]
                                                            .sellNt18k) >=
                                                    0
                                                ? Colors.green.shade600
                                                : Colors.red.shade600,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GoldChartForm(
                                    goldTypeChart: 'NT24K',
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Vàng nữ trang 24K',
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              )),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].buyNt24k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Raleway',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].buyNt24k -
                                            snapshot.data[0].buyNt24k),
                                        style: TextStyle(
                                          color: (snapshot.data[1].buyNt24k -
                                                      snapshot
                                                          .data[0].buyNt24k) >=
                                                  0
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                          fontFamily: 'Raleway',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].sellNt24k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].sellNt24k -
                                            snapshot.data[0].sellNt24k),
                                        style: TextStyle(
                                            color: (snapshot.data[1].sellNt24k -
                                                        snapshot.data[0]
                                                            .sellNt24k) >=
                                                    0
                                                ? Colors.green.shade600
                                                : Colors.red.shade600,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GoldChartForm(
                                    goldTypeChart: 'NHAN24K',
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Vàng nhẫn 24K',
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              )),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].buyNhan24k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Raleway',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].buyNhan24k -
                                            snapshot.data[0].buyNhan24k),
                                        style: TextStyle(
                                          color: (snapshot.data[1].buyNhan24k -
                                                      snapshot.data[0]
                                                          .buyNhan24k) >=
                                                  0
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                          fontFamily: 'Raleway',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[0].sellNhan24k),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                          decimalDigits: 0,
                                        ).format(snapshot.data[1].sellNhan24k -
                                            snapshot.data[0].sellNhan24k),
                                        style: TextStyle(
                                            color:
                                                (snapshot.data[1].sellNhan24k -
                                                            snapshot.data[0]
                                                                .sellNhan24k) >=
                                                        0
                                                    ? Colors.green.shade600
                                                    : Colors.red.shade600,
                                            fontSize: 16.0,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ));
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
