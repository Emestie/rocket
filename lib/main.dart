import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/stores/app.dart';
import 'package:rocket/stores/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './views/main_view.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppStore(),
      ),
      ChangeNotifierProvider(create: (context) => DataStore(prefs))
    ],
    child: const App(),
  ));
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
