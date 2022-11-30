import 'package:flutter/material.dart';

class agenda_page extends StatefulWidget {
  const agenda_page({super.key});

  @override
  State<agenda_page> createState() => _agenda_pageState();
}

class _agenda_pageState extends State<agenda_page> {
  late DateTime SelectDay;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Proximamente ...'),
    );
  }
}
