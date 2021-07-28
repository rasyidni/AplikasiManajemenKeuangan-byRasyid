import 'dart:convert';
/* Kelas untuk mengelola obyek event/acara */
class ItemPendapatan {
   int PendapatanId;
   int PendapatanDate;
   String PendapatanName;
   int JumlahPendapatan;
   int isCompleted;
   ItemPendapatan(
       {
         this.PendapatanId,
         this.PendapatanDate,
         this.PendapatanName,
         this.JumlahPendapatan,
         this.isCompleted
       }
    );
   /* Fungsi untuk mengonversi JSON ke EventItem */
   factory ItemPendapatan.fromJson(Map<String, dynamic> json) {
     return new ItemPendapatan (
      PendapatanId: json['PendapatanId'] as int,
      PendapatanDate: json['PendapatanDate'] as int,
      PendapatanName: json['PendapatanName'] as String,
      JumlahPendapatan: json['JumlahPendapatan'] as int,
       isCompleted: json['isCompleted'] as int,
     );
   }
   /* Fungsi untuk mengonversi EventItem ke JSON */
   Map<String, dynamic> toJson() => {
     'PendapatanId': PendapatanId,
     'PendapatanDate': PendapatanDate,
     'PendapatanName': PendapatanName,
     'JumlahPendapatan': JumlahPendapatan,
     'isCompleted': isCompleted,
   };
   /* Fungsi untuk mengonversi EventItem ke tipe data Map.
      Tidak berbeda dengan fungsi toJson sebetulnya.
      Ini digunakan untuk mengirim obyek ke tabel database
   */
   Map<String, dynamic> toMap() {
     return {
       'PendapatanId': PendapatanId,
       'PendapatanDate': PendapatanDate,
       'PendapatanName': PendapatanName,
       'JumlahPendapatan': JumlahPendapatan,
       'isCompleted': isCompleted,
     };
   }
   /* Fungsi untuk mengonversi EventItem ke Map.
      Tidak berbeda dengan toMap hanya saja tidak menyertakan eventId.
      Ini digunakan sebagai obyek masukan ke tabel
      di mana eventId bersifat AUTOINCREMENT
   */
   Map<String, dynamic> toMapInsert() {
     return {
       'PendapatanDate': PendapatanDate,
       'PendapatanName': PendapatanName,
       'JumlahPendapatan': JumlahPendapatan,
       'isCompleted': isCompleted,
     };
   }
   /* Fungsi untuk mengonversi Map ke EventItem.
      Ini digunakan untuk menampung baris (row) data
      dari tabel database
   */
   ItemPendapatan.fromMap(Map<String, dynamic> map) {
     PendapatanId = map['PendapatanId'];
     PendapatanDate = map['PendapatanDate'];
     PendapatanName = map['PendapatanName'];
     JumlahPendapatan = map['JumlahPendapatan'];
     isCompleted = map['isCompleted'];
   }
   /* Fungsi untuk mengonversi EventItem ke String.
      Ini digunakan untuk menyimpan obyek ke SharedPreferences
   */
   @override
   String toString() {
     var jsonData = json.encode(toJson());
     return jsonData;
   }
}
/* Kelas untuk mengelola obyek guest/tamu */
class ItemPengeluaran {
  int PengeluaranId;
  int PengeluaranDate;
  String PengeluaranName;
  int JumlahPengeluaran;
  int isCompleted;
  ItemPengeluaran(
      {
        this.PengeluaranId,
        this.PengeluaranDate,
        this.PengeluaranName,
        this.JumlahPengeluaran,
        this.isCompleted
      }
   );
  /* Fungsi untuk mengonversi JSON ke ItemPengeluaran */
  factory ItemPengeluaran.fromJson(Map<String, dynamic> json) {
    return new ItemPengeluaran (
     PengeluaranId: json['PengeluaranId'] as int,
     PengeluaranDate: json['PengeluaranDate'] as int,
     PengeluaranName: json['PengeluaranName'] as String,
     JumlahPengeluaran: json['JumlahPengeluaran'] as int,
     isCompleted: json['isCompleted'] as int,
    );
  }
  /* Fungsi untuk mengonversi ItemPengeluaran ke JSON */
  Map<String, dynamic> toJson() => {
    'PengeluaranId': PengeluaranId,
    'PengeluaranDate': PengeluaranDate,
    'PengeluaranName': PengeluaranName,
    'JumlahPengeluaran': JumlahPengeluaran,
    'isCompleted': isCompleted,
  };
  /* Fungsi untuk mengonversi ItemPengeluaran ke tipe data Map.
     Tidak berbeda dengan fungsi toJson sebetulnya.
     Ini digunakan untuk mengirim obyek ke tabel database
  */
  Map<String, dynamic> toMap() {
    return {
      'PengeluaranId': PengeluaranId,
      'PengeluaranDate': PengeluaranDate,
      'PengeluaranName': PengeluaranName,
      'JumlahPengeluaran': JumlahPengeluaran,
      'isCompleted': isCompleted,
    };
  }
  /* Fungsi untuk mengonversi ItemPengeluaran ke Map.
     Tidak berbeda dengan toMap hanya saja tidak menyertakan guestId.
     Ini digunakan sebagai obyek masukan ke tabel
     di mana guestId bersifat AUTOINCREMENT
  */
  Map<String, dynamic> toMapInsert() {
    return {
       'PengeluaranDate': PengeluaranDate,
       'PengeluaranName': PengeluaranName,
       'JumlahPengeluaran': JumlahPengeluaran,
       'isCompleted': isCompleted,
    };
  }
  /* Fungsi untuk mengonversi Map ke ItemPengeluaran.
     Ini digunakan untuk menampung baris (row) data
     dari tabel database
  */
  ItemPengeluaran.fromMap(Map<String, dynamic> map) {
    PengeluaranId = map['PengeluaranId'];
    PengeluaranDate = map['PengeluaranDate'];
    PengeluaranName = map['PengeluaranName'];
    JumlahPengeluaran = map['JumlahPengeluaran'];
    isCompleted = map['isCompleted'];
  }
  /* Fungsi untuk mengonversi ItemPengeluaran ke String.
     Ini digunakan untuk menyimpan obyek ke SharedPreferences
  */
  @override
  String toString() {
    var jsonData = json.encode(toJson());
    return jsonData;
  }
}
/* Kelas untuk mengelola obyek kolom/field dari tabel database */
class ColumnItem {
  final String name;
  final String type;
  final String extra;
  const ColumnItem(
      {
        this.name,
        this.type,
        this.extra,
      }
  );
}
/* Daftar konstanta untuk menentukan kolom-kolom pada tabel event di database.
   Terdiri dari 3 argumen:
   - name : menentukan nama kolom
   - type : menentukan tipe data kolom
   - extra : menentukan argumen pembuatan kolom lainnya
*/
const List<ColumnItem> pendapatanColumns = const <ColumnItem>[
  const ColumnItem(name: "PendapatanId", type: "INTEGER", extra: "PRIMARY KEY AUTOINCREMENT"),
  const ColumnItem(name: "PendapatanDate", type: "INTEGER", extra: ""),
  const ColumnItem(name: "PendapatanName", type: "VARCHAR(50)", extra: ""),
  const ColumnItem(name: "JumlahPendapatan", type: "INTEGER", extra: ""),
  const ColumnItem(name: "isCompleted", type: "INTEGER", extra: ""),
];
/* Daftar konstanta untuk menentukan kolom-kolom pada tabel guest di database */
const List<ColumnItem> pengeluaranColumns = const <ColumnItem>[
  const ColumnItem(name: "PengeluaranId", type: "INTEGER", extra: "PRIMARY KEY AUTOINCREMENT"),
  const ColumnItem(name: "PengeluaranDate", type: "INTEGER", extra: ""),
  const ColumnItem(name: "PengeluaranName", type: "VARCHAR(50)", extra: ""),
  const ColumnItem(name: "JumlahPengeluaran", type: "INTEGER", extra: ""),
  const ColumnItem(name: "isCompleted", type: "INTEGER", extra: ""),
];
/* Fungsi unttuk mengambil nama kolom */
List<String> getColumnsName(List<ColumnItem> columnItems){
  List<String> result = new List();
  for (ColumnItem columnItem in columnItems){
    result.add(columnItem.name);
  }
  return result;
}