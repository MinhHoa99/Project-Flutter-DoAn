import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinCard extends StatelessWidget {
  CoinCard(
      {this.name,
      this.symbol,
      this.imageURL,
      this.price,
      this.change,
      this.changePercentage});

  final String name;
  final String symbol;
  final String imageURL;
  final double price;
  final double change;
  final double changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.network(imageURL),
              ),
              height: 70,
              width: 70,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      symbol,
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat.simpleCurrency(
                      locale: 'vi_VN',
                      decimalDigits: 0,
                    ).format(price),
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.simpleCurrency(
                            locale: 'vi_VN', decimalDigits: 0)
                        .format(change.toDouble()),
                    style: TextStyle(
                      color: change.toDouble() < 0
                          ? Colors.red.shade400
                          : Colors.green.shade400,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    changePercentage.toDouble() < 0
                        ? changePercentage.toDouble().toStringAsFixed(2) + '%'
                        : '+' + changePercentage.toDouble().toString() + '%',
                    style: TextStyle(
                      color: changePercentage.toDouble() < 0
                          ? Colors.red.shade400
                          : Colors.green.shade400,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
