import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mailer2/mailer.dart';
import 'package:toast/toast.dart';

import 'emailBilgileri.dart';

class Passwordforget extends StatefulWidget {
  @override
  State<Passwordforget> createState() => _PasswordforgetState();
}

class _PasswordforgetState extends State<Passwordforget> {
  int rastgeleSayi;
  String emailDogrulma = "", kodGirilen = "", kisiNo = "";
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "uygulama adı",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: double.maxFinite,
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Container(
                    color: Colors.orange,
                    margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                    child: TextField(
                      onChanged: (String email) {
                        setState(() {
                          emailDogrulma = email;
                        });
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'e-meil',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        prefixText: "",
                        suffixText: "TR",
                        suffixStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  //kullanıcı şifresi girişi

                  new Container(
                      color: Colors.orange,
                      margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 20.0),
                      child: new TextField(
                        onChanged: (String kod) {
                          setState(() {
                            kodGirilen = kod;
                          });
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Kodu Giriniz',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                        cursorColor: Colors.white,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          color: Colors.orange,
                          child: TextButton(
                            child: Text(
                              "  KOD-AL  ",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              kodSayiGonder();
                            },
                          )),
                      Padding(padding: EdgeInsets.only(right: 20)),
                      new Container(
                          color: Colors.orange,
                          child: TextButton(
                            child: Text(
                              "  ONAYLA  ",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              kodKontrol();
                            },
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  sayiuret() {
    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    rastgeleSayi = min + randomizer.nextInt(max - min);
    print(rastgeleSayi);
  }

  Future kodSayiGonder() async {
    sayiuret();
    // ignore: unused_local_variable
    String varmi = "";
    final db = FirebaseDatabase.instance.reference();

    for (var i = 1; i < 4; i++) {
      db.child(i.toString() + "/email").once().then((DataSnapshot snapshot) {
        String sorEmail = '${snapshot.value}';
        if (emailDogrulma == sorEmail) {
          setState(() {
            kisiNo = i.toString();
          });

          setState(() {
            var options = new GmailSmtpOptions()
              ..username = EMAIL
              ..password = PASS;

            var emailTransport = new SmtpTransport(options);

            // Create our mail/envelope.
            var envelope = new Envelope()
              ..recipients.add(emailDogrulma) //alici  gmail i
              ..subject = ' Hesap Dogrulama'
              ..text = ' Hesap Dogrulama kodu'
              ..html =
                  '<h1>DOGRULAMA KODUNUZ</h1><p>"${rastgeleSayi.toString()}"</p>'; //burda mesaj içeriği var

            // Email it.
            emailTransport
                .send(envelope)
                .then((envelope) => {
                      Toast.show(
                          "LÜTFEN MAİL ADRESİNİZİ KONTROL EDİNİZ BİRAZ (2-3)DK ZAMAN ALABİLİR",
                          context,
                          duration: 5,
                          gravity: Toast.BOTTOM)
                    }) //gurda bize meail gönderildiyse bilgi veriyor
                // ignore: return_of_invalid_type_from_catch_error
                // ignore: argument_type_not_assignable_to_error_handler
                .catchError(() => {
                      Toast.show(
                          "LÜTFEN MAİL ADRESİNİZİ KONTROL EDİNİZ", context,
                          duration: 3, gravity: Toast.BOTTOM)
                    }); //burdada gönderilmediğinde bilgi veriyor
          });
        } else {}
      });
    }
  }

  Future kodKontrol() async {
    if (kodGirilen == rastgeleSayi.toString()) {
      final db = FirebaseDatabase.instance.reference();
      db.child(kisiNo + "/password").once().then((DataSnapshot snapshot) {
        String gelenPass = '${snapshot.value}';
        var options = new GmailSmtpOptions()
          ..username = EMAIL
          ..password = PASS;

        var emailTransport = new SmtpTransport(options);

        // Create our mail/envelope.
        var envelope = new Envelope()
          ..recipients.add(emailDogrulma) //alici  gmail i
          ..subject = ' HESAP Dogrulama'
          ..text = ' HESAP SİFRENİZ'
          ..html =
              '<h1>GIRIS SİFRENİZ</h1><p>"${gelenPass.toString()}"</p>'; //burda mesaj içeriği var

        // Email it.
        emailTransport
            .send(envelope)
            .then((envelope) => {
                  Toast.show(
                      "SİFRENİZ E-MEAL ADRESSİNİZE GÖDERİLMİŞTİR", context,
                      duration: 3, gravity: Toast.BOTTOM),
                  Navigator.pushNamed(context, "/")
                }) //gurda bize meail gönderildiyse bilgi veriyor
            // ignore: return_of_invalid_type_from_catch_error, argument_type_not_assignable_to_error_handler
            .catchError(() => {
                  Toast.show("LÜTFEN MAİL ADRESİNİZİ KONTROL EDİNİZ", context,
                      duration: 3, gravity: Toast.BOTTOM)
                }); //burdada gönderilmediğinde bilgi veriyor
      });
    }
  }
}
