import 'dart:io';

import 'package:rocket/code/helpers.dart';

//VS
void startVS(String path) {
  Process.run('start', [path], runInShell: true);
}

//VS Code
void startVSCode(String path) {
  var executable = Platform.isWindows ? "code.cmd" : "code";
  Process.run(executable, ['-n', preparePath(path)]);
}
