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
void startPowershell(String path) {
  Process.start("powershell.exe", ['-noexit', '-command', preparePath(path)],
      runInShell: true, mode: ProcessStartMode.detached);
}

//PowerShell Core
void startPowershellCore(String path) {
  Process.start("pwsh.exe", ['-noexit', '-command', preparePath(path)],
      runInShell: true, mode: ProcessStartMode.detached);
}

//Mac Terminal
void startTerminal(String path) {
  var preparedPath = preparePath(path);

  Process.run('/usr/bin/osascript',
      ['-e', 'tell app "Terminal" to do script "$preparedPath"']);
}
