import 'dart:async';
import 'dart:convert';

import 'package:doan_flutter/bitcoin_chart/components/bitcoin_chart_form.dart';
import 'package:doan_flutter/models/Coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CoinCard.dart';

class ElectronicMoneyForm extends StatefulWidget {
  @override
  _ElectronicMoneyFormState createState() => _ElectronicMoneyFormState();
}

class _ElectronicMoneyFormState extends State<ElectronicMoneyForm> {
  List<Coin> coinList = [];

  Future<List<Coin>> fetchCoins() async {
    String queryString =
        'vs_currency=vnd&order=market_cap_desc&per_page=10&page=1&sparkline=false';

    String url =
        'https://api.coingecko.com/api/v3/coins/markets?' + queryString;
    var header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      var listCoin = json.decode(response.body) as List<dynamic>;

      List<Coin> results =
          listCoin.map((itemCoin) => Coin.fromJson(itemCoin)).toList();

      if (mounted) {
        setState(() {
          coinList = results;
        });
      }

      return results;
    } else {
      throw Exception('Failed to load data.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCoins();
    Timer.periodic(Duration(seconds: 5), (timer) => fetchCoins());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: coinList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BitcoinchartForm(
                      idCoin: coinList[index].id,
                    )));
          },
          child: CoinCard(
            name: coinList[index].name,
            symbol: coinList[index].symbol,
            imageURL: coinList[index].imageURL,
            price: coinList[index].price.toDouble(),
            change: coinList[index].change.toDouble(),
            changePercentage: coinList[index].changePercentage.toDouble(),
          ),
        );
      },
    );
  }
}
