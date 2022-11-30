import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/agenda_page.dart';
import 'package:proyecto/src/pages/home.dart';
import 'package:proyecto/src/pages/login_page.dart';
import 'package:proyecto/src/pages/publication.dart';
import 'package:proyecto/src/pages/register.dart';
import 'package:proyecto/src/pages/splashscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RAUU",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
