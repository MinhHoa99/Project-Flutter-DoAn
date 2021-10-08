import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyConversionForm extends StatefulWidget {
  @override
  _CurrencyConversionFormState createState() => _CurrencyConversionFormState();
}

class Item {
  String name;
  Image img;

  Item({this.name, this.img});
}

class _CurrencyConversionFormState extends State<CurrencyConversionForm> {
  Item selectedUser1;
  Item selectedUser2;
  List<Item> users = <Item>[
    Item(
        name: 'VN',
        img: Image.asset(
          'assets/VN.png',
          width: 30,
          height: 30,
        )),
    Item(
        name: 'UK',
        img: Image.asset(
          'assets/UK.png',
          width: 30,
          height: 30,
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 250.0, right: 40, left: 40),
        child: IntrinsicHeight(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(children: <Widget>[
                Expanded(
                  child: Row(children: <Widget>[
                    Container(height: 20.0, color: Colors.black),
                    SizedBox(
                      width: 140.0,
                      child: DropdownButtonFormField<Item>(
                        decoration: InputDecoration.collapsed(hintText: ''),
                        hint: Text(
                          'Chọn quốc gia',
                          style: TextStyle(
                              color: Colors.indigoAccent, fontSize: 17.0),
                        ),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        style: const TextStyle(color: Colors.deepPurple),
                        value: selectedUser1,
                        // ignore: non_constant_identifier_names
                        onChanged: (Item i) {
                          setState(() {
                            selectedUser1 = i;
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                user.img,
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user.name,
                                  style: TextStyle(
                                      color: Colors.indigoAccent, fontSize: 20),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: '_ _ _ _',
                          contentPadding: new EdgeInsets.only(right: 20.0),
                          border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(children: <Widget>[
                Expanded(
                  child: Row(children: <Widget>[
                    Container(height: 20.0, color: Colors.red),
                    SizedBox(
                      width: 140.0,
                      child: DropdownButtonFormField<Item>(
                        decoration: InputDecoration.collapsed(hintText: ''),
                        hint: Text(
                          "Chọn quốc gia",
                          style: TextStyle(
                              fontSize: 17.0, color: Colors.indigoAccent),
                        ),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        style: const TextStyle(color: Colors.deepPurple),
                        value: selectedUser2,
                        // ignore: non_constant_identifier_names
                        onChanged: (Item i) {
                          setState(() {
                            selectedUser2 = i;
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                user.img,
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user.name,
                                  style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: '_ _ _ _',
                          contentPadding: new EdgeInsets.only(right: 20.0),
                          border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ],
        )));
  }
}
