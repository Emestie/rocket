import 'package:flutter/material.dart';

getSettingsViewRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: const Text("Settings"));
  });
}
