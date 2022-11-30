import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proyecto/libs/http.dart';
import 'package:proyecto/src/pages/agenda_page.dart';
import 'package:proyecto/src/pages/home.dart';
import 'package:proyecto/src/pages/profilepage.dart';
import 'package:proyecto/src/pages/new_publication.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';

class pagePublication extends StatefulWidget {
  const pagePublication({super.key});

  @override
  State<pagePublication> createState() => _publicationState();
}

class _publicationState extends State<pagePublication> {
  int index = 0;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _dato = new TextEditingController();
    String _path = "";
    return Scaffold(
      appBar: AppBar(title: Text('R A A U'), actions: <Widget>[
        /*IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PageNewPublication(),
              ));
            },
            icon: Icon(Icons.upload)
            )*/
      ]),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [home(), PageNewPublication(), profilepage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int i) {
            setState(() {
              index = i;
              _controller.animateToPage(i,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: 'Publicar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
          ]),
    );
  }
}
