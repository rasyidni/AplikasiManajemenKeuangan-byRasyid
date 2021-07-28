import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

var tablePendapatan = 'tblPendapatan';
var tablePengeluaran = 'tblPengeluaran';

class DatabaseProvider {
  Database database;
  /* Fungsi untuk membuka kelas database */
  Future open() async {
    var databasesPath = await getDatabasesPath();
    /* Menentukan nama dan alamat database */
    String path = join(databasesPath, 'pendapatandanpengeluaran.db');
    /* Membuka database */
    database = await openDatabase(
      path,
      version: 1,
      /* Membuat tabel bila belum terdapat tabel pada database */
      onCreate: (Database db, int version) async {
        /* Membangun query pembuatan tabel tblEvent */
        String sqlTablePendapatan = "CREATE TABLE $tablePendapatan (";
        for (var i = 0; i < pendapatanColumns.length; i++) {
          ColumnItem columnItem = pendapatanColumns[i];
          sqlTablePendapatan +=
              columnItem.name + " " + columnItem.type + " " + columnItem.extra;
          if (i < (pendapatanColumns.length - 1)) {
            sqlTablePendapatan += ",";
          }
        }
        sqlTablePendapatan += ");";
        /* Membuat query pembuatan indeks pada table tblEvent */
        String indexTablePendapatan = " CREATE INDEX idx_" +
            tablePendapatan +
            "_" +
            "row_event" +
            " ON " +
            tablePendapatan +
            " (" +
            pendapatanColumns[0].name +
            ");";

        /* Membangun query pembuatan tabel tblGuest */
        String sqlTablePengeluaran = "CREATE TABLE $tablePengeluaran (";
        for (var i = 0; i < pengeluaranColumns.length; i++) {
          ColumnItem columnItem = pengeluaranColumns[i];
          sqlTablePengeluaran +=
              columnItem.name + " " + columnItem.type + " " + columnItem.extra;
          if (i < (pengeluaranColumns.length - 1)) {
            sqlTablePengeluaran += ",";
          }
        }
        sqlTablePengeluaran += ");";
        /* Membuat query pembuatan indeks pada table tblGuest */
        String indexTablePengeluaran = " CREATE INDEX idx_" +
            tablePengeluaran +
            "_" +
            "row_guest" +
            " ON " +
            tablePengeluaran +
            " (" +
            pengeluaranColumns[0].name +
            ");";

        /* Mengeksekusi query pembuatan tabel-tabel */
        db.execute(sqlTablePendapatan);
        db.execute(indexTablePendapatan);
        db.execute(sqlTablePengeluaran);
        db.execute(indexTablePengeluaran);
      },
    );
  }

  /* Fungsi untuk menutup kelas database */
  Future close() async => database.close();
  /* Fungsi untuk menambah baris ke tabel tblEvent */
  Future<ItemPendapatan> insertEvent(ItemPendapatan event) async {
    event.PendapatanId =
        await database.insert(tablePendapatan, event.toMapInsert());
    return event;
  }

  /* Fungsi untuk menghapus baris di tabel tblEvent */
  Future<int> deleteEvent(int id) async {
    return await database.delete(tablePendapatan,
        where: pendapatanColumns[0].name + ' = ?', whereArgs: [id]);
  }

  /* Fungsi untuk memperbarui baris di tabel tblEvent */
  Future<int> updateEvent(ItemPendapatan event) async {
    return await database.update(tablePendapatan, event.toMap(),
        where: pendapatanColumns[0].name + ' = ?',
        whereArgs: [event.PendapatanId]);
  }

  /* Fungsi untuk mengambil daftar baris di tabel tblEvent */
  Future<List<ItemPendapatan>> getListEvent() async {
    List<Map> maps = await database.query(tablePendapatan,
        columns: getColumnsName(pendapatanColumns));
    List<ItemPendapatan> listEvent = List();
    if (maps.length > 0) {
      for (Map map in maps) {
        ItemPendapatan event = ItemPendapatan.fromMap(map);
        listEvent.add(event);
      }
      return listEvent;
    }
    return listEvent;
  }

  /* Fungsi untuk menambah baris ke tabel tblGuest */
  Future<ItemPengeluaran> insertGuest(ItemPengeluaran guest) async {
    guest.PengeluaranId =
        await database.insert(tablePengeluaran, guest.toMapInsert());
    return guest;
  }

  /* Fungsi untuk menghapus baris di tabel tblGuest */
  Future<int> deleteGuest(int id) async {
    return await database.delete(tablePengeluaran,
        where: pengeluaranColumns[0].name + ' = ?', whereArgs: [id]);
  }

  /* Fungsi untuk memperbarui baris ke tabel tblGuest */
  Future<int> updateGuest(ItemPengeluaran guest) async {
    return await database.update(tablePengeluaran, guest.toMap(),
        where: pengeluaranColumns[0].name + ' = ?',
        whereArgs: [guest.PengeluaranId]);
  }

  /* Fungsi untuk mengambil daftar baris di tabel tblGuest berdasarkan eventId */
  Future<List<ItemPengeluaran>> getListGuest() async {
    List<Map> maps = await database.query(tablePengeluaran,
        columns: getColumnsName(pengeluaranColumns));
    List<ItemPengeluaran> listGuest = List();
    if (maps.length > 0) {
      for (Map map in maps) {
        ItemPengeluaran event = ItemPengeluaran.fromMap(map);
        listGuest.add(event);
      }
      return listGuest;
    }
    return listGuest;
  }

/* Fungsi untuk mengambil hasil jumlah pengeluaran dari tabel pengeluaran berdasarkan bulan */
  Future<int> hitungtotal({int month, int tahun}) async {
    int jumlahpengeluaran = 0;
    List<Map> maps = await database.query(tablePengeluaran,
        columns: getColumnsName(pengeluaranColumns));
    if (maps.length > 0) {
      for (Map map in maps) {
        var date =
            new DateTime.fromMillisecondsSinceEpoch(map["PengeluaranDate"]);
        int monthp = date.month;
        int tahunp = date.year;
        if (month == monthp && tahun == tahunp) {
          jumlahpengeluaran += map["JumlahPengeluaran"];
        }
      }
    }
    print(jumlahpengeluaran);
    return jumlahpengeluaran;
  }

/* Fungsi untuk mengambil hasil jumlah pendapatan dari tabel pendapatan berdasarkan bulan */
  Future<int> hitungtotalpe({int month, int tahun}) async {
    int jumlahpendapatan = 0;
    List<Map> maps = await database.query(tablePendapatan,
        columns: getColumnsName(pendapatanColumns));
    if (maps.length > 0) {
      for (Map map in maps) {
        var date =
            new DateTime.fromMillisecondsSinceEpoch(map["PendapatanDate"]);
        int monthp = date.month;
        int tahunp = date.year;
        if (month == monthp && tahun == tahunp) {
          jumlahpendapatan += map["JumlahPendapatan"];
        }
      }
    }
    return jumlahpendapatan;
  }

  rawQuery(String s) {}

  calculateTotal() {}
}
