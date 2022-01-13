import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/code/updater.dart';
import 'package:rocket/stores/exposed.dart';

import './views/main_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStoresAndPreferences();

  if (Platform.isMacOS) {
    await DesktopWindow.setWindowSize(const Size(800, 600));
    await DesktopWindow.setMinWindowSize(const Size(640, 480));
    await DesktopWindow.setMaxWindowSize(const Size(960, 640));
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => appStore,
      ),
      ChangeNotifierProvider(create: (context) => dataStore)
    ],
    child: const App(),
  ));

  startUpdateChecker();
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  final appTitle = "Rocket";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MainView(appTitle),
      debugShowCheckedModeBanner: false,
    );
  }
}
