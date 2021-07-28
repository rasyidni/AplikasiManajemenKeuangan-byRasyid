import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Tentang Aplikasi",
    home: new tentangaplikasi(),
  ));
}

class tentangaplikasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Tentang Aplikasi"),
      ),
      body: Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(color: Colors.lightBlue),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Text(
                      "Aplikasi ini dibuat oleh Rasyid Noor Imamsyah dengan NIM DBC118031, yang bertujuan untuk melaksanakan tugas PP yang diberikan oleh Dosen."),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Text(
                      "Aplikasi ini bertujuan untuk mempermudah umkm dalam memanajemen keuangannya sehingga ia dapat nelihat keuntungan dan kerugian dari usahanya perbulan tanpa harus menghitung secara manual."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
