import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

// ignore: non_constant_identifier_names
dynamic K_ADI;
String emailLogin = "", gelenEmail = "";
String passwordLogin = "", gelenpass = "";

class _LoginState extends State<Login> {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //kullanıcı adı grişi
                new Container(
                  color: Colors.orange,
                  margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  child: TextField(
                    onChanged: (String email) {
                      setState(() {
                        emailLogin = email;
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
                      onChanged: (String password) {
                        setState(() {
                          passwordLogin = password;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                //şifremi unuttum
                new Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      "SİFREMİ UNUTTUM",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/passwordForget");
                    },
                  ),
                ),

                new Container(
                    color: Colors.orange,
                    child: TextButton(
                      child: Text(
                        "  Giriş Yap  ",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        loginfonk();
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future loginfonk() async {
    setState(() {
      final db = FirebaseDatabase.instance.reference();

      for (var i = 1; i < 4; i++) {
        db.child(i.toString() + "/email").once().then((DataSnapshot snapshot) {
          setState(() {
            gelenEmail = '${snapshot.value}';

            if (emailLogin == gelenEmail) {
              print(gelenEmail + "/" + emailLogin);
              db
                  .child(i.toString() + "/password")
                  .once()
                  .then((DataSnapshot snapshot) {
                gelenpass = '${snapshot.value}';

                if (gelenpass == passwordLogin) {
                  db
                      .child(i.toString() + "/position")
                      .once()
                      .then((DataSnapshot snapshot) {
                    String a = '${snapshot.value}';
                    K_ADI = a;
                  });
                  print(gelenpass + "/" + passwordLogin);
                  Navigator.pushNamed(context, "/firstPege");
                } else {
                  Toast.show("SİFRENİZİ YADA E-MAİL HATALI GİRDİNİZ", context,
                      duration: 3, gravity: Toast.BOTTOM);
                }
              });
            } else {}
          });
        });
      }
    });
  }
}
