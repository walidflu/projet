import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Daterange.dart';
import 'Navigationbar.dart';
import 'Dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavigationBAR',
      debugShowCheckedModeBanner: false,
      home: NavigationBAR(),
    );
  }
}






