import 'package:flutter/material.dart';

import 'form.dart';

class PageRegister extends StatefulWidget {
  static String id = 'register';

  @override
  State<PageRegister> createState() => _register();
}

class _register extends State<PageRegister> {
  var message = null;
  @override
  Widget build(BuildContext context) {
    Map<String, TextEditingController> controllers = {
      'name': TextEditingController(),
      'surname': TextEditingController(),
      'user': TextEditingController(),
      'email': TextEditingController(),
      'password': TextEditingController()
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
                  height: 200.0,
                ),
              ),
              formWidget.name(controllers['name']),
              SizedBox(
                height: 15.0,
                width: 10.0,
              ),
              formWidget.last_name(controllers['surname']),
              SizedBox(
                height: 15.0,
              ),
              formWidget.user(controllers['user']),
              SizedBox(
                height: 15.0,
              ),
              formWidget.email(controllers['email']),
              SizedBox(
                height: 15.0,
              ),
              formWidget.password(controllers['password']),
              SizedBox(
                height: 15.0,
              ),
              Text(message ?? ""),
              (message == "Registrandose...")
                  ? Text("")
                  : formWidget.btn_register(controllers, this),
              SizedBox(
                height: 15.0,
              ),
              (message == "Registrandose...")
                  ? Text("")
                  : formWidget.btn_page_login(controllers),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
