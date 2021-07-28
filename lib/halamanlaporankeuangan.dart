import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_keuangan/database.dart';

class Halamanlaporan extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<Halamanlaporan> {
  TextEditingController _tahun = new TextEditingController();
  DatabaseProvider databaseProvider = new DatabaseProvider();
  int _year = 2021;
  int _month = 1;
  int pengeluaran = 0;
  int pendapatan = 0;
  int keuntungan = 0;
  int kerugian = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (pendapatan == 0 && pengeluaran == 0) {
        kerugian = 0;
        keuntungan = 0;
      } else {
        if (pendapatan > pengeluaran) {
          keuntungan = pendapatan - pengeluaran;
          kerugian = 0;
        } else if (pengeluaran > pendapatan) {
          kerugian = pengeluaran - pendapatan;
          keuntungan = 0;
        } else if (pendapatan == pengeluaran) {
          keuntungan = 0;
          kerugian = 0;
        }
      }
    });
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 40.0, bottom: 15.0, top: 15.0),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Text("Pendapatan (Rp)  : "),
                    Text(pendapatan.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Pengeluaran (Rp) : "),
                    Text(pengeluaran.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Keuntungan (Rp)  : "),
                    Text(keuntungan.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Kerugian (Rp)    : "),
                    Text(kerugian.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Bulan            : "),
                    DropdownButton(
                      value: _month,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "Januari",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Februari",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Maret",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          value: 3,
                        ),
                        DropdownMenuItem(
                            child: Text(
                              "April",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 4),
                        DropdownMenuItem(
                            child: Text(
                              "Mei",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 5),
                        DropdownMenuItem(
                            child: Text(
                              "Juni",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 6),
                        DropdownMenuItem(
                            child: Text(
                              "Juli",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 7),
                        DropdownMenuItem(
                            child: Text(
                              "Agustus",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 8),
                        DropdownMenuItem(
                            child: Text(
                              "September",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 9),
                        DropdownMenuItem(
                            child: Text(
                              "Oktober",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 10),
                        DropdownMenuItem(
                            child: Text(
                              "November",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 11),
                        DropdownMenuItem(
                            child: Text(
                              "Desember",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 12),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _month = value;
                        });
                        print(value);
                        databaseProvider.open().then((_) {
                          databaseProvider
                              .hitungtotal(month: value, tahun: _year)
                              .then((value) => setState(() {
                                    pengeluaran = value;
                                  }));
                          databaseProvider
                              .hitungtotalpe(month: value, tahun: _year)
                              .then((value) => setState(() {
                                    pendapatan = value;
                                  }));
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Tahun            : "),
                    DropdownButton(
                      value: _year,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "2021",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          value: 2021,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "2022",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          value: 2022,
                        ),
                        DropdownMenuItem(
                            child: Text(
                              "2023",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2023),
                        DropdownMenuItem(
                            child: Text(
                              "2024",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2024),
                        DropdownMenuItem(
                            child: Text(
                              "2025",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2025),
                        DropdownMenuItem(
                            child: Text(
                              "2026",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2026),
                        DropdownMenuItem(
                            child: Text(
                              "2027",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2027),
                        DropdownMenuItem(
                            child: Text(
                              "2028",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2028),
                        DropdownMenuItem(
                            child: Text(
                              "2029",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2029),
                        DropdownMenuItem(
                            child: Text(
                              "2030",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            value: 2030),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _year = value;
                        });
                        print(value);
                        databaseProvider.open().then((_) {
                          databaseProvider
                              .hitungtotal(month: _month, tahun: value)
                              .then((value) => setState(() {
                                    pengeluaran = value;
                                  }));
                          databaseProvider
                              .hitungtotalpe(month: _month, tahun: value)
                              .then((value) => setState(() {
                                    pendapatan = value;
                                  }));
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
