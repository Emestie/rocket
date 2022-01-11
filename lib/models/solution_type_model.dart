import 'dart:io';

import 'package:flutter/material.dart';

enum OS { unknown, win, mac }

OS currentOs() {
  if (Platform.isWindows) return OS.win;
  if (Platform.isMacOS) return OS.mac;
  return OS.unknown;
}

List<SolutionType> _solutionTypes = [
  SolutionType(
      1, 'Visual Studio', Image.asset('assets/vs.png'), [OS.win], (path) {}),
  SolutionType(
      2, 'VS Code', Image.asset('assets/vs-code.png'), [OS.win, OS.mac],
      (path) async {
    // print("opening vscode " + path);
    // var p = Process.start("/usr/local/bin/code", ["-n", path]);
    //Process.run('open', ['~/test.txt']);
  })
];

List<SolutionType> getAvailableSolutionTypes() {
  return _solutionTypes
      .where((element) => element.platforms.contains(currentOs()))
      .toList();
}

SolutionType getSolutionTypeById(int id) {
  return _solutionTypes.firstWhere((element) => element.id == id);
}

class SolutionType {
  int id;
  String name;
  Widget icon;
  List<OS> platforms;
  Function(String path) startMethod;

  SolutionType(this.id, this.name, this.icon, this.platforms, this.startMethod);
}
