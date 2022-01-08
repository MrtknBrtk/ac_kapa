import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'login.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

// ignore: deprecated_member_use
List dataP = new List();
// ignore: deprecated_member_use
List dataI = new List();
// ignore: deprecated_member_use
List dataT = new List();
// ignore: deprecated_member_use
List dataGelEmail = new List();
// ignore: avoid_init_to_null
int sycData = null;

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    setState(() {
      dataGel();
    });

    super.initState();
  }

  Future dataGel() async {
    dataP = [];
    dataT = [];
    dataI = [];
    print("object");
    setState(() {
      final db = FirebaseDatabase.instance.reference();
      db.child("dataSyc/Dsayac/sayac").once().then((DataSnapshot snapshot) {
        var b = '${snapshot.value}';
        sycData = int.parse(b);

        for (var i = (sycData - 1); i >= 0; i--) {
          db
              .child("data/" + i.toString() + "/position")
              .once()
              .then((DataSnapshot snapshot) {
            print('${snapshot.value}');
            String a = '${snapshot.value}';
            setState(() {
              dataP.add(a);
            });
          });
          db
              .child("data/" + i.toString() + "/islem")
              .once()
              .then((DataSnapshot snapshot) {
            String b = '${snapshot.value}';
            setState(() {
              dataI.add(b);
            });
          });
          db
              .child("data/" + i.toString() + "/date")
              .once()
              .then((DataSnapshot snapshot) {
            String c = '${snapshot.value}';
            setState(() {
              dataT.add(c);
            });
          });
        }
      });
    });
  }

  String elkOpen = "";
  String elkClose = "";
  String elkOkey = "";
  Future dataClose() async {
    // ignore: avoid_init_to_null
    int syc = null;
    String date = DateTime.now().toString();
    final db = FirebaseDatabase.instance.reference();
    db.child("dataSyc/Dsayac/sayac").once().then((DataSnapshot snapshot) {
      String a = '${snapshot.value}';
      print(a);
      syc = int.parse(a);

      if (syc == 0) {
        db.child("data/0/").set({
          "position": K_ADI.toString(),
          "islem": "ELEKTRİK KAPAT",
          "date": date,
        });
        db.child("dataSyc/Dsayac/").update({
          "sayac": (syc + 1).toString(),
        });
        dataGel();
      } else {
        db
            .child("data/" + (syc - 1).toString() + "/islem")
            .once()
            .then((DataSnapshot snapshot) {
          String gelenDeger = '${snapshot.value}';
          print(gelenDeger);
          if (gelenDeger == elkClose) {
            Toast.show("EN SON YAPILAN İŞLEMLE AYNI YAPILAMAZ", context,
                duration: 3, gravity: Toast.BOTTOM);
          } else {
            String date = DateTime.now().toString();
            db.child("data/" + (syc).toString() + "/").set({
              "position": K_ADI.toString(),
              "islem": "ELEKTRİK KAPAT",
              "date": date,
            });
            db.child("dataSyc/Dsayac/").update({
              "sayac": (syc + 1).toString(),
            });
            dataGel();
          }
        });
      }
    });
  }

  Future dataAdd() async {
    // ignore: avoid_init_to_null
    int syc = null;

    final db = FirebaseDatabase.instance.reference();
    db.child("dataSyc/Dsayac/sayac").once().then((DataSnapshot snapshot) {
      String a = '${snapshot.value}';
      print(a);
      syc = int.parse(a);

      if (syc == 0) {
        String date = DateTime.now().toString();
        db.child("data/0/").set({
          "position": K_ADI.toString(),
          "islem": "ELEKTRİK AÇ",
          "date": date,
        });
        db.child("dataSyc/Dsayac/").update({
          "sayac": (syc + 1).toString(),
        });
        dataGel();
      } else {
        db
            .child("data/" + (syc - 1).toString() + "/islem")
            .once()
            .then((DataSnapshot snapshot) {
          String gelenDeger = '${snapshot.value}';
          print(gelenDeger);
          if (gelenDeger == elkOpen) {
            Toast.show("EN SON YAPILAN İŞLEMLE AYNI YAPILAMAZ", context,
                duration: 3, gravity: Toast.BOTTOM);
          } else {
            String date = DateTime.now().toString();
            db.child("data/" + (syc).toString() + "/").set({
              "position": K_ADI.toString(),
              "islem": "ELEKTRİK AÇ",
              "date": date,
            });
            db.child("dataSyc/Dsayac/").update({
              "sayac": (syc + 1).toString(),
            });
            dataGel();
          }
        });
      }
    });
  }

  Future dataTmm() async {
    // ignore: avoid_init_to_null
    int syc = null;

    final db = FirebaseDatabase.instance.reference();
    db.child("dataSyc/Dsayac/sayac").once().then((DataSnapshot snapshot) {
      String a = '${snapshot.value}';
      print(a);
      syc = int.parse(a);

      if (syc == 0) {
        String date = DateTime.now().toString();
        db.child("data/0/").set({
          "position": K_ADI.toString(),
          "islem": "TAMAM",
          "date": date,
        });
        db.child("dataSyc/Dsayac/").update({
          "sayac": (syc + 1).toString(),
        });
        dataGel();
      } else {
        db
            .child("data/" + (syc - 1).toString() + "/islem")
            .once()
            .then((DataSnapshot snapshot) {
          String gelenDeger = '${snapshot.value}';
          print(gelenDeger);
          if (gelenDeger == elkOkey) {
            Toast.show("EN SON YAPILAN İŞLEMLE AYNI YAPILAMAZ", context,
                duration: 3, gravity: Toast.BOTTOM);
          } else {
            String date = DateTime.now().toString();
            db.child("data/" + (syc).toString() + "/").set({
              "position": K_ADI.toString(),
              "islem": "TAMAM",
              "date": date,
            });
            db.child("dataSyc/Dsayac/").update({
              "sayac": (syc + 1).toString(),
            });
            dataGel();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "uygulama adı",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.orange,
      ),
      body: Container(
          width: double.maxFinite,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.centerLeft,
                      color: Colors.orange,
                      child: TextButton(
                        child: Text(" ELEKTRİK AÇ "),
                        onPressed: () {
                          setState(() {
                            elkOpen = "ELEKTRİK AÇ";
                          });
                          dataAdd();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      alignment: Alignment.centerRight,
                      color: Colors.orange,
                      child: TextButton(
                        child: Text(" ELEKTRİK KAPAT "),
                        onPressed: () {
                          setState(() {
                            elkClose = "ELEKTRİK KAPAT";
                          });
                          dataClose();
                        },
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      alignment: Alignment.center,
                      color: Colors.orange,
                      child: TextButton(
                        child: Text(" TAMAM "),
                        onPressed: () {
                          setState(() {
                            elkOkey = "TAMAM";
                          });
                          dataTmm();
                        },
                      ),
                    ),
                  ],
                ),
                DataTable(
                  columnSpacing: double.minPositive + 10,
                  showBottomBorder: true,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Posizyon',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'işlem',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'tarih ve saat',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: [
                    for (int i = 0; i < dataT.length; i++)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(dataP[i])),
                          DataCell(Text(dataI[i])),
                          DataCell(
                            Text(dataT[i]),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
