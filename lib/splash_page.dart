import 'package:doan_flutter/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashPage extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    });
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
      ),
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/SplashPage.png', width: 500, height: 500,),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    ));
  }
}
