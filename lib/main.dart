import 'package:ac_kapa/firstPege.dart';
import 'package:ac_kapa/login.dart';
import 'package:ac_kapa/passwordForget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Login(),
      "/firstPege": (context) => FirstPage(),
      "/passwordForget": (context) => Passwordforget(),
    },
  ));
}
