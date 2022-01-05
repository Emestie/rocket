import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/models/app_model.dart';

import 'solution_manage_view.dart';
import 'settings_view.dart';

class MainView extends StatefulWidget {
  const MainView(this.appTitle, {Key? key}) : super(key: key);
  final String appTitle;

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Function() goToView(String name) {
    return () {
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
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appTitle),
          actions: [
            Consumer<AppModel>(
              builder: (_, app, __) => IconButton(
                  onPressed: app.toggleAppMode, icon: const Icon(Icons.edit)),
            ),
            IconButton(
                onPressed: goToView("settings"),
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Consumer<AppModel>(
                builder: (_, app, __) => Text("app mode: ${app.mode}"),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ));
  }
}
