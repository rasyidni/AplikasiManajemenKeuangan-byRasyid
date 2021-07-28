import 'package:flutter/material.dart';
import 'model.dart';
import 'database.dart';
import 'package:fluttertoast/fluttertoast.dart';

/* Activity  untuk menambah atau mengedit list pengeluaran */
class EventActivity extends StatefulWidget {
  const EventActivity({Key key, this.event}) : super(key: key);
  final ItemPengeluaran event;
  @override
  EventPage createState() {
    return EventPage();
  }
}

class EventPage extends State<EventActivity> {
  ItemPengeluaran _pengeluaran;
  String _selDate = '';
  String _selName = '';
  String _JumlahPengeluaran;
  TextEditingController _controllerDate = new TextEditingController();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerJumlahPengeluaran =
      new TextEditingController();
  /* Inisialisasi awal */
  @override
  void initState() {
    /* Mengambil nilai dari widget.event dan mengisinya ke _pengeluaran */
    _pengeluaran = widget.event;
    /* Jika _pengeluaran/widget.event tidak null
      (mode pengeditan event)
    */
    if (_pengeluaran != null) {
      /* mengambil data event sebelumnya */
      _selName = _pengeluaran.PengeluaranName;
      _JumlahPengeluaran = _pengeluaran.JumlahPengeluaran.toString();
      _selDate = formatDate(new DateTime.fromMillisecondsSinceEpoch(
          _pengeluaran.PengeluaranDate));
      /* Menampilkan pada TextField melalui perantara TextEditingController */
      _controllerName.text = _selName;
      _controllerJumlahPengeluaran.text = _JumlahPengeluaran;
      _controllerDate.text = _selDate;
    }
    super.initState();
  }

  /* Fungsi untuk mengonversi angka di bawah 10 menjadi 2 digit.
     Misalnya: 01, 02, 03, dst sampai 09
  */
  String sprintF(var number) {
    return number.toString().padLeft(2, "0");
  }

  /* Mengonversi tipe DateTime menjadi format tanggal.
     Misalnya: 2-02-2019
  */
  String formatDate(DateTime date) {
    int year = date.year;
    int month = date.month;
    int day = date.day;
    return day.toString() + "-" + sprintF(month) + "-" + year.toString();
  }

  /* Fungsi untuk menampilkan dialog DatePicker */
  Future selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2021),
        lastDate: new DateTime(2030));
    if (picked != null)
      setState(() {
        /* Menyimpan nilai pada _selDate */
        _selDate = formatDate(picked);
        /* Menampilkan pada TextField */
        _controllerDate.text = _selDate;
      });
  }

  /* Metode untuk menyimpan event */
  void saveEvent() {
    bool isNew = false;
    /* Jika _pengeluaran null (tidak ada kiriman event dari Navigator) */
    if (_pengeluaran == null) {
      _pengeluaran = new ItemPengeluaran();
      _pengeluaran.isCompleted = 0;
      /* Tandai sebagai event baru */
      isNew = true;
    }
    /* Mengisi variabel _pengeluaran */
    _pengeluaran.PengeluaranName = _selName;
    _pengeluaran.JumlahPengeluaran = int.parse(_JumlahPengeluaran);
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    /* Mengisi _pengeluaran.createDate dengan millisecond saat ini
       (saat tombol ditap)
    */
    /* Mengonversi data dari TextField */
    /* Jika _selDate tidak kosong (jika memilih tanggal) */
    if (_selDate.isNotEmpty) {
      List<String> arrDate = _selDate.split("-");
      if (arrDate.length == 3) {
        day = int.parse(arrDate[0]);
        month = int.parse(arrDate[1]);
        year = int.parse(arrDate[2]);
      }
    }
    var selDTDate = new DateTime(year, month, day, 0, 0, 0);
    _pengeluaran.PengeluaranDate = selDTDate.millisecondsSinceEpoch;

    DatabaseProvider databaseProvider = new DatabaseProvider();
    /* Jika event merupakan event baru */
    if (isNew) {
      /* Membuka database */
      databaseProvider.open().then((value) {
        /* Menambahkan event ke database */
        databaseProvider.insertGuest(_pengeluaran).then((event) {
          /* Menampilkan Toast */
          Fluttertoast.showToast(
              msg: "Pengeluaran berhasil ditambahkan",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1);
          /* Menutup database */
          databaseProvider.close();
          /* Menutup activity */
          Navigator.pop(context, _pengeluaran);
        });
      });
      /* Jika event bukan merupakan event baru (mode edit) */
    } else {
      /* Membuka database */
      databaseProvider.open().then((value) {
        /* Memperbarui event di database */
        databaseProvider.updateGuest(_pengeluaran).then((event) {
          /* Menampilkan Toast */
          Fluttertoast.showToast(
              msg: "Pengeluaran berhasil diperbarui",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1);
          /* Menutup database */
          databaseProvider.close();
          /* Menutup activity dan mengirim _pengeluaran ke Navigator */
          Navigator.pop(context, _pengeluaran);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        /* Mnggunakan widget Stack agar dapat memanfaatkan widget Positioned.
        Positioned.fill digunakan untuk membuat tampilan satu layar penuh
        */
        children: <Widget>[
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: Card(
                elevation: 4.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  side: BorderSide(
                    color: Colors.lightBlue,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.lightBlue,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 120,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Tanggal",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: _controllerDate,
                                  onTap: selectDate,
                                  textInputAction: TextInputAction.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.lightBlue,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 120,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Nama Pengeluaran",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: _controllerName,
                                  autocorrect: false,
                                  textCapitalization: TextCapitalization.words,
                                  onChanged: (value) {
                                    setState(() {
                                      _selName = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.lightBlue,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 120,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Jumlah (Rp)",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLines: 3,
                                  minLines: 2,
                                  controller: _controllerJumlahPengeluaran,
                                  autocorrect: false,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  onChanged: (value) {
                                    setState(() {
                                      _JumlahPengeluaran = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveEvent,
        backgroundColor: Colors.white,
        tooltip: 'Tambah Pengeluaran',
        child: Icon(
          Icons.save,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
