import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rocket/code/starters.dart';
import 'package:rocket/code/validators.dart';

enum OS { unknown, win, mac }

OS currentOs() {
  if (Platform.isWindows) return OS.win;
  if (Platform.isMacOS) return OS.mac;
  return OS.unknown;
}

List<SolutionType> _solutionTypes = [
  SolutionType(
      id: 1,
      name: 'Visual Studio',
      icon: Image.asset('assets/vs.png'),
      platforms: [OS.win],
      starter: startVS,
      validate: validateVS,
      commandExampleText: "C:\\path\\to\\solution.sln"),
  SolutionType(
      id: 2,
      name: 'VS Code',
      icon: Image.asset('assets/vs-code.png'),
      platforms: [OS.win, OS.mac],
      starter: startVSCode,
      validate: emptyValidator,
      commandExampleText:
          "/path/to/any/folder/to/open\nOR\nC:\\path\\to\\any\\folder\\to\\open"),
  SolutionType(
      id: 3,
      name: 'Finder',
      icon: Image.asset('assets/finder.png'),
      platforms: [OS.mac],
      starter: startFinder,
      validate: emptyValidator,
      commandExampleText: "/path/to/folder"),
  SolutionType(
      id: 4,
      name: "Explorer",
      icon: Image.asset('assets/explorer.png'),
      platforms: [OS.win],
      starter: startExplorer,
      validate: emptyValidator,
      commandExampleText: "C:\\path\\to\\folder"),
  SolutionType(
      id: 5,
      name: "Windows PowerShell",
      icon: Image.asset('assets/ps.png'),
      platforms: [OS.win],
      starter: startPowershell,
      validate: emptyValidator,
      commandExampleText: "cd C:\\any\\path ; anotherCommand.cmd"),
  SolutionType(
      id: 6,
      name: "PowerShell Core",
      icon: Image.asset('assets/ps-core.png'),
      platforms: [OS.win],
      starter: startPowershellCore,
      validate: emptyValidator,
      commandExampleText: "cd C:\\any\\path && anotherCommand.cmd"),
  SolutionType(
      id: 7,
      name: "Terminal",
      icon: Image.asset('assets/terminal.png'),
      platforms: [OS.mac],
      starter: startTerminal,
      validate: emptyValidator,
      commandExampleText: "cd /any/path && ls && anyCommandAnyFile"),
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
  Function(String path) starter;
  Function(String path, String name) validate;
  String commandExampleText;

  SolutionType(
      {required this.id,
      required this.name,
      required this.icon,
      required this.platforms,
      required this.starter,
      required this.validate,
      required this.commandExampleText});
}
