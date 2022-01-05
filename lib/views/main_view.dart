import 'package:flutter/material.dart';

import 'solution_manage_view.dart';
import 'settings_view.dart';

class MainView extends StatefulWidget {
  const MainView(this.appTitle, {Key? key}) : super(key: key);
  final String appTitle;

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void goToView(String name) {
    void pushView(view) {
      Navigator.of(context).push(view);
    }

    switch (name) {
      case 'settings':
        pushView(getSettingsViewRoute());
        break;
      case 'add':
        pushView(getAddViewRoute());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appTitle),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () => goToView("settings"),
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: Column(
            children: const [Text("Text11")],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ));
  }
}
