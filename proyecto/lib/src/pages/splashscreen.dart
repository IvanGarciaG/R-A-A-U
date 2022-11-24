

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/login_page.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
@override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Spacer(),
       Center(child: FractionallySizedBox(widthFactor:.6 ,child:Image.asset( height:500 ,width:500,'assets/logo.png') ,)),
       Spacer(),
        CircularProgressIndicator(),
        Spacer(),
        Text('Bienvenido'),
        Spacer(),
      ],
      ),
    );
  }
}