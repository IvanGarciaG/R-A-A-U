import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/agenda_page.dart';
import 'package:proyecto/src/pages/home.dart';
import 'package:proyecto/src/pages/profilepage.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';



class publication extends StatefulWidget {
  const publication({super.key});

  @override
  State<publication> createState() => _publicationState();
}

class _publicationState extends State<publication> {
    int index=0;
    late PageController _controller;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('R A A U'),
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          home(),
          agenda_page(),
          profilepage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ( int i){
          setState(() {
            index=i;
            _controller.animateToPage(i, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
          });
        },
        items:
        [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Inicio',
            ),

             BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded), 
            label: 'Calendario',
            ),

             BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), 
            label: 'Perfil',
            ),
        ]
        ),






    );
  }
}