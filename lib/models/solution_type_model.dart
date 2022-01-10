import 'dart:io';

import 'package:flutter/material.dart';

enum OS { unknown, win, mac }

OS currentOs() {
  if (Platform.isWindows) return OS.win;
  if (Platform.isMacOS) return OS.mac;
  return OS.unknown;
}

List<SolutionType> _solutionTypes = [
  SolutionType(1, 'Visual Studio', Image.asset('assets/vs.png'), [OS.win]),
  SolutionType(
      2, 'VS Code', Image.asset('assets/vs-code.png'), [OS.win, OS.mac])
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

  SolutionType(this.id, this.name, this.icon, this.platforms);
}
