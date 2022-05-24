import 'package:flutter/material.dart';
import 'package:learn_ap1/Register/login_page.dart';
import 'package:learn_ap1/Register/signUp_page.dart';
import 'package:learn_ap1/example_four.dart';
import 'package:learn_ap1/example_thrid.dart';
import 'package:learn_ap1/example_two.dart';
import 'package:learn_ap1/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}
