import 'package:flutter/material.dart';

import 'form.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Map<String,TextEditingController> controllers={
      'email':TextEditingController(),
      'password':TextEditingController()
    };
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  'assets/logo.png',
                  height: 300.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              formWidget.email(controllers['email']),
              SizedBox(
                height: 15,
              ),
              formWidget.password(controllers['password']),
              SizedBox(
                height: 20.0,
              ),
              formWidget.btn_login(controllers),
              SizedBox(
                height: 20.0,
              ),
              formWidget.btn_pag_register(controllers)
            ],
          ),
        ),
      ),
    );
  }
}