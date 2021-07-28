import 'package:aplikasi_manajemen_keuangan/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Halaman Home",
    home: new Halamanhome(),
  ));
}

// ignore: must_be_immutable
class Halamanhome extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 15.0),
                margin: EdgeInsets.only(bottom: 10.0),
                child: Column(children: <Widget>[
                    Text("Informasi Pengguna",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 60.0, top: 5.0),
                      child : Text("Nama  : ${user.displayName}",textAlign: TextAlign.justify)),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 60.0, top: 5.0),
                      child : Text("Email   : ${user.email}",textAlign: TextAlign.justify,)),
                ])),
            Container(
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
                  new Text(
                      "Untuk menggunakan aplikasi ini pertama-tama anda harus memasukkan jumlah dan jenis pendapatan yang anda dapatkan pada submenu pendapatan di menu transaksi"),
                ],
              ),
            ),
            Container(
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
                  new Text(
                      "Kemudian anda dapat memasukkan jumlah dan jenis pengeluaran yang anda miliki pada submenu pengeluaran di menu transaksi"),
                ],
              ),
            ),
            Container(
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
                  new Text(
                      "Lalu setelah anda memasukkan pendapatan dan pengeluaran, anda dapat melihat laporan keuangan anda pada bagian menu laporan keuangan."),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text('Logout'),
                onPressed: () async {
                  await auth.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
