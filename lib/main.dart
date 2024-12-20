import 'package:flutter/material.dart';
import 'package:memo_app/src/screens/create_idea.dart';
import 'package:memo_app/src/screens/ideas.dart';
import 'src/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/create': (BuildContext context) => CreateIdeaPage(),
        '/ideas': (BuildContext context) => IdeasPage() 
      },
    );
  }
}
