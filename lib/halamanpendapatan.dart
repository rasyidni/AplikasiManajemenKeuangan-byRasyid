import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'model.dart';
import 'database.dart';
import 'listpendapatan.dart';

class HalPendapatan extends StatelessWidget {
  TabController controller;

  HalPendapatan(this.controller);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Pendapatan',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MainActivity(title: 'Daftar Pendapatan'),
    );
  }
}

/* Activity utama, untuk menampilkan daftar event/acara */
class MainActivity extends StatefulWidget {
  MainActivity({Key key, this.title}) : super(key: key);
  final String title;
  @override
  MainPage createState() => MainPage();
}

class MainPage extends State<MainActivity> {
  ItemPendapatan _event;
  List<ItemPendapatan> _listEvent = new List();
  DatabaseProvider databaseProvider = new DatabaseProvider();
  /* Inisialisasi awal */
  @override
  void initState() {
    /* Memanggil metode createDefaultEvent */
    createDefaultEvent();
    super.initState();
    /* Memuat data pada ListView */
    _refreshList();
  }

  /* Metode untuk membuat event/acara otomatis
     saat tabel belum mempunyai satupun baris acara
  */
  void createDefaultEvent() {
    /* Membuka koneksi ke database */
    databaseProvider.open().then((_) {
      /* Memanggil fungsi getListEvent untuk mengoleksi daftar event */
      databaseProvider.getListEvent();
    });
  }

  /* Metode untuk memuat ulang daftar event */
  void _refreshList() {
    /* Membuka database */
    databaseProvider.open().then((_) {
      /* Memanggil fungsi getListEvent untuk mengambil daftar event */
      databaseProvider.getListEvent().then((list) {
        if (list != null) {
          /* Memperbarui variabel _listEvent */
          setState(() {
            _listEvent = list;
          });
          /* Menutup database */
          databaseProvider.close();
        }
      });
    });
  }

  /* Mengonversi millisecond (unix time) menjadi format tanggal.
     Misalnya: 22 Januari 2019
  */
  String formatDate(int millis) {
    if (millis != null) {
      var date = new DateTime.fromMillisecondsSinceEpoch(millis);
      int year = date.year;
      int month = date.month;
      int day = date.day;
      List<String> monthNames = [
        "",
        "Januari",
        "Februari",
        "Maret",
        "April",
        "Mei",
        "Juni",
        "Juli",
        "Agustus",
        "September",
        "Oktober",
        "November",
        "Desember"
      ];
      return day.toString() + " " + monthNames[month] + " " + year.toString();
    }
    return '';
  }

  /* Fungsi untuk membuat widget item dari ListView */
  Widget createEventItem(ItemPendapatan event) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6.0),
        ),
        side: BorderSide(
          color: Colors.lightBlue.shade200,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
          side: BorderSide(
            color: Colors.lightBlue.shade200,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        event.PendapatanName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        formatDate(event.PendapatanDate) + " ",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black45,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Rp. ${event.JumlahPendapatan}",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black45,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        /* Saat tombol edit (pensil) ditap */
                        onTap: () {
                          /* Simpan nilai event pada variabel _event */
                          setState(() {
                            _event = event;
                          });
                          /* Memanggil EventActivity untuk pengeditan event */
                          showEventActivity();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        /* Saat tombol hapus (tong sampah) ditap */
                        onTap: () {
                          if (_listEvent.length > 0) {
                            /* Simpan nilai event pada variabel _event */
                            setState(() {
                              _event = event;
                            });
                            /* Menampilkan dialog konfirmasi penghaspusan */
                            showDeleteDialog();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* Fungsi untuk membangun daftar item dari ListView */
  Widget listViewBuilder(BuildContext context, int index) {
    ItemPendapatan event = _listEvent[index];
    return createEventItem(event);
  }

  /* Metode untuk menampilkan EventActivity */
  void showEventActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventActivity(
          event: _event,
        ),
      ),
    ).then((value) {
      /* memuat ulang ListView saat MainActivity tampil kembali */
      if (value != null)
        setState(() {
          _refreshList();
        });
    });
  }

  /* Metode untuk menampilkan dialog konfirmasi penghapusan event */
  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hapus"),
          content: Text("Ingin menghapus pendapatan?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ya"),
              /* Saat mengetap/mengklik tombol Ya pada dialog */
              onPressed: () {
                /* Membuka database */
                databaseProvider.open().then((value) {
                  /* Menghapus event dari database */
                  databaseProvider
                      .deleteEvent(_event.PendapatanId)
                      .then((event) {
                    /* Menampilkan Toast setelah penghapusan */
                    Fluttertoast.showToast(
                        msg: "Pendapatan berhasil dihapus",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1);
                    /* Menghapus item event dari _listEvent.
                       Menggunakan setState agar item-item pada
                       _listEvent diperbarui sehingga daftar item
                       pada ListView ikut diperbarui
                    */
                    setState(() {
                      _listEvent.remove(event);
                    });
                    /* Menutup database */
                    databaseProvider.close();
                    /* Menutup dialog */
                    Navigator.of(context).pop();
                  });
                });
              },
            ),
            FlatButton(
              child: Text("Tidak"),
              /* Saat mengetap/mengklik tombol Tidak pada dialog */
              onPressed: () {
                /* Menutup dialog */
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _loading = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text("Menyiapkan Data")
        ],
      ),
    );
    Widget _blank = Center(
      child: Container(
        height: 40,
        child: Text("Belum ada pendapatan yang dimasukkan"),
      ),
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
        ),
        child: Card(
          elevation: 4.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            side: BorderSide(
              color: Colors.lightBlue.shade400,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  /* Menggunakan FutureBuilder untuk mengakses database */
                  child: FutureBuilder(
                    future: databaseProvider.open(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      /* Saat koneksi ke database berhasil terhubung */
                      if (snapshot.connectionState == ConnectionState.done) {
                        return FutureBuilder(
                          /* Menggunakan FutureBuilder untuk mengambil daftar event */
                          future: databaseProvider.getListEvent(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            /* Saat pemanggilan fungsi mendapatkan data */
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                /* Mengisi variabel _listEvent dari data snapshot */
                                _listEvent = snapshot.data;
                                databaseProvider.close();
                                /* Saat _listEvent kosong */
                                if (_listEvent.length == 0) {
                                  /* Tampilkan widget _blank */
                                  return _blank;
                                  /* Saat _listEvent tidak kosong */
                                } else {
                                  /* Bangun widget ListView */
                                  return ListView.builder(
                                    itemCount: _listEvent.length,
                                    itemBuilder: listViewBuilder,
                                  );
                                }
                              } else {
                                return _blank;
                              }
                            } else {
                              return _blank;
                            }
                          },
                        );
                      } else {
                        return _loading;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /* Saat FloatingActionButton ditap */
        onPressed: () {
          /* Null-kan nilai _event */
          setState(() {
            _event = null;
          });
          /* Memanggil EventActivity */
          showEventActivity();
        },
        backgroundColor: Colors.white,
        tooltip: 'Tambah Pendapatan',
        child: Icon(
          Icons.add_box,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
