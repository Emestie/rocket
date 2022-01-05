import 'package:flutter/material.dart';

getAddViewRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add")), body: const Text("Add"));
  });
}
