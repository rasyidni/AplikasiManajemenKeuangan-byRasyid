import 'package:flutter/material.dart';
import './halamanpendapatan.dart' as tabpagesatu;
import './halamanpengeluaran.dart' as tabpagedua;


class Halamantransaksi extends StatefulWidget {
  @override
  _TabFlutterState createState() => _TabFlutterState();
}

class _TabFlutterState extends State<Halamantransaksi>  with SingleTickerProviderStateMixin{
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //create appBar
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
      child : new AppBar(
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: 'Pendapatan',
            ),
            Tab(
              text: 'Pengeluaran',
            ),
          ],
        ),
      ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          tabpagesatu.HalPendapatan(controller),
          tabpagedua.HalPengeluaran(),
        ],
      ),
    );
  }
}