import 'package:aplikasi3_api/berita.dart';
import 'package:aplikasi3_api/cuaca.dart';
import 'package:aplikasi3_api/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: NewsScreen());
  }
}
