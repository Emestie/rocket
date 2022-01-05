import 'package:flutter/material.dart';

import './views/main_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  final appTitle = "Rocket";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MainView(appTitle),
      debugShowCheckedModeBanner: false,
    );
  }
}
