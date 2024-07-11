import 'package:flutter/material.dart';
import 'halaman1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik Cahya Amalia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Halaman1(),
    );
  }
}
