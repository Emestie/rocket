import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/group/group_container.dart';
import 'package:rocket/enums.dart';
import 'package:rocket/stores/app_store.dart';
import 'dart:io';

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
            TextButton(onPressed: () {}, child: const Text("Install update")),
            Consumer<AppStore>(
              builder: (_, app, __) => IconButton(
                  onPressed: app.toggleAppMode,
                  icon: app.mode == AppMode.view
                      ? const Icon(Icons.edit)
                      : const Icon(Icons.done)),
            ),
            IconButton(
                onPressed: goToView("settings"),
                icon: const Icon(Icons.settings)),
            IconButton(
                onPressed: () {
                  Process.run("code", ["~/Code"]);
                },
                icon: const Icon(Icons.run_circle))
          ],
        ),
        body: const GroupContainer());
  }
}
