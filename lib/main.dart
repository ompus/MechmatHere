import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мехмат.Тут',
      // настройка темы
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // Исходная страница
      home: HomePage(),
    );
  }
}