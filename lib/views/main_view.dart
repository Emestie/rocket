import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/dialogs/alert_dialog.dart';
import 'package:rocket/components/group/group_container.dart';
import 'package:rocket/enums.dart';
import 'package:rocket/stores/app_store.dart';

import 'settings_view.dart';

class MainView extends StatefulWidget {
  const MainView(this.appTitle, {Key? key}) : super(key: key);
  final String appTitle;

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void showPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String os = Platform.isWindows ? 'win' : 'mac';

    var text = "$appName - $version ($buildNumber) [$os]";

    showAlertDialog(context, title: "About", text: text);
  }

  Function() goToView(String name) {
    return () {
      void pushView(view) {
        Navigator.of(context).push(view);
      }

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
        body: const GroupContainer());
  }
}
