import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Halaman Kontak",
    home: new Kontak(),
  ));
}

class Kontak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Kontak"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/instagram.png',
                  height: 30,
                  width: 30,
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left :65),
              ),
              Container(
                child: Text("@Rasyidnis"),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/facebook.png',
                  height: 30,
                  width: 30,
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left :65),
              ),
              Container(
                child: Text("Rasyid Noor Imamsyah"),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/gmail.png',
                  height: 30,
                  width: 30,
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left :65),
              ),
              Container(
                child: Text("Rasyidni700@gmail.com"),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/whatsapp.png',
                  height: 30,
                  width: 30,
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left :65),
              ),
              Container(
                child: Text("0896 9280 8688"),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
              )
            ],
          )
        ],
      ),
    );
  }
}
