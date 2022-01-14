import 'dart:io';

import 'package:rocket/code/helpers.dart';

//VS
void startVS(String path) {
  Process.run('start', [path], runInShell: true);
}

//VS Code
void startVSCode(String path) {
  var executable = Platform.isWindows ? "code.cmd" : "/usr/local/bin/code";
  var dirArg = (path.contains("://") ? "--folder-uri" : "");

  Process.run(executable, ['-n', dirArg, preparePath(path)]);
}

//Finder
void startFinder(String path) {
  Process.run("open", [preparePath(path)], runInShell: true);
}

//Explorer
void startExplorer(String path) {
  Process.run("explorer.exe", [preparePath(path)], runInShell: true);
}

//PowerShell for Windows

//PowerShell Core
void startPowershellCore(String path) {
  var executable = Platform.isWindows ? "pwsh.exe" : "/usr/local/bin/pwsh";

  Process.start(
      executable, ['-noexit', '-command', '"' + preparePath(path) + '"'],
      runInShell: true, mode: ProcessStartMode.detached);
  // Process.start(
  //         'open',
  //         [
  //           '-a',
  //           'PowerShell',
  //           '--args',
  //           '-noexit',
  //           '-command',
  //           preparePath(path)
  //         ],
  //         workingDirectory: "/",
  //         mode: ProcessStartMode.detached,
  //         runInShell: true)
  //     .then((value) => value.stdin.write("cd / && ls"));
}

//Mac Terminal
void startTerminal(String path) {
  var preparedPath = preparePath(path);

  Process.run('/usr/bin/osascript',
      ['-e', 'tell app "Terminal" to do script "$preparedPath"']);
}
