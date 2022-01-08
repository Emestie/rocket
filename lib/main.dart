import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/stores/exposed.dart';

import './views/main_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStoresAndPreferences();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => appStore,
      ),
      ChangeNotifierProvider(create: (context) => dataStore)
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
