import 'dart:io';

String getHomePath() {
  Map<String, String> envVars = Platform.environment;
  String? home = "";

  if (Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  return home ?? "";
}

String preparePath(String path) {
  var home = getHomePath();

  return path.replaceFirst('~', home);
}
