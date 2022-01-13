import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show SystemNavigator, rootBundle;
import 'package:http/http.dart' as http;
import 'package:rocket/stores/exposed.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> loadAppVersion() async {
  return await rootBundle.loadString('__APPVER.txt');
}

Future<String> loadServerVersion() async {
  var data = await http.get(Uri.parse(
      'https://github.com/Emestie/rocket/releases/latest/download/__APPVER.txt'));

  return data.body == "Not Found" ? "0.0.0" : data.body;
}

void openUpdatePage() async {
  await launch("https://github.com/Emestie/rocket/releases/latest");
  exit(0);
}

Future<bool> checkUpdateAvailability() async {
  var currentVersion = await loadAppVersion();
  var serverVersion = await loadServerVersion();

  var convCV = _convertSemverToZeroedString(currentVersion);
  var convSV = _convertSemverToZeroedString(serverVersion);

  return convCV.compareTo(convSV) < 0;
}

String _convertSemverToZeroedString(String semver) {
  var pieces = semver.split(".");
  List<String> list = [];

  for (var i = 0; i < pieces.length; i++) {
    var nums = pieces[i].split("-");
    var n = nums[0];
    var appdx = "";

    if (n.length == 1) appdx = "000";
    if (n.length == 2) appdx = "00";
    if (n.length == 3) appdx = "0";

    list.add(appdx + n);
  }

  return list.join(".");
}

void startUpdateChecker() {
  void checkUpdate() async {
    bool hasUpdate = await checkUpdateAvailability();
    print('checking ' + hasUpdate.toString());
    if (!hasUpdate) return;
    appStore?.setHasUpdate(true);
  }

  checkUpdate();

  Timer.periodic(const Duration(seconds: 10), (timer) {
    checkUpdate();
  });
}
