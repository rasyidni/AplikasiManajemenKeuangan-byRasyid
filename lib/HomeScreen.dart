import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'halamanhome.dart';
import 'halamanlaporankeuangan.dart';
import 'halamantransaksi.dart';
import 'kontak.dart';
import 'tentangaplikasi.dart';

//kelas myapp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        textTheme: GoogleFonts.robotoCondensedTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: BelajarNavBar(),
      routes: {
        '/kontak': (context) => Kontak(),
        '/tentangaplikasi': (context) => tentangaplikasi(),
      },
    );
  }
}
//kelas myapp

//kelas belajarnavbar
class BelajarNavBar extends StatefulWidget {
  @override
  _BelajarNavBarState createState() => _BelajarNavBarState();
}
//kelas belajarnavbar

//kelas belajarnavbarstate
class _BelajarNavBarState extends State<BelajarNavBar> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }
//kelas belajarnavbarstate

  final _widgetOptions = [
    Halamanhome(),
    Halamanlaporan(),
    Halamantransaksi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Manajemen Keuangan"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Manajemen Keuangan',
                style: TextStyle(fontSize: 16.0),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(
                'Tentang Aplikasi',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tentangaplikasi');
              },
            ),
            ListTile(
              title: Text(
                'Kontak',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/kontak');
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedNavbar),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Laporan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_alt_rounded),
            title: Text('Transaksi'),
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.lightBlue,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
