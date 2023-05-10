import 'package:flutter/material.dart';
import 'package:moor_test/home.dart';
import 'package:moor_test/moor_database.dart';
import 'package:provider/provider.dart';


void main()=>runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context)=>MyDatabase(),
      child: const MaterialApp(
        home:  HomePage(),
      ),
    );
  }
}