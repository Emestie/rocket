import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/code/updater.dart';
import 'package:rocket/components/dialogs/alert_dialog.dart';
import 'package:rocket/components/group/group_container.dart';
import 'package:rocket/enums.dart';
import 'package:rocket/stores/app_store.dart';

class MainView extends StatefulWidget {
  const MainView(this.appTitle, {Key? key}) : super(key: key);
  final String appTitle;

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void showPackageInfo() async {
    var ver = await loadAppVersion();
    var platform = Platform.isWindows ? "win" : "mac";

    showAlertDialog(context,
        title: "About", text: "Version: " + ver + " ($platform)");
  }

  Function() goToView(String name) {
    return () {
      // void pushView(view) {
      //   Navigator.of(context).push(view);
      // }

      switch (name) {
        case 'settings':
          showPackageInfo();
          //pushView(getSettingsViewRoute());
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
          Consumer<AppStore>(builder: (_, app, __) {
            if (!app.hasUpdate) return Container();

            return TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.green),
              onPressed: openUpdatePage,
              child: const Text("INSTALL UPDATE"),
            );
          }),
          Consumer<AppStore>(
            builder: (_, app, __) => IconButton(
                onPressed: app.toggleAppMode,
                icon: app.mode == AppMode.view
                    ? const Icon(Icons.edit)
                    : const Icon(Icons.done)),
          ),
          IconButton(
              onPressed: goToView("settings"),
              icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: const GroupContainer(),
    );
  }
}
