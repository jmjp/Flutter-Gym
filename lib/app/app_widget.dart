import 'package:flutter/material.dart';
import 'package:fluttergym/app/pages/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gym',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeModule(),
      debugShowCheckedModeBanner: false,
    );
  }
}
