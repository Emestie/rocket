import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:rocket/models/group.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore extends ChangeNotifier {
  List<Group> groups = [];
  int lastId = 0;

  DataStore(SharedPreferences prefs) {
    final json = prefs.getString('Data') ?? "{}";
    final object = jsonDecode(json);

    groups =
        (object['groups'] ?? []).map((x) => Group.fromJson(x)); //.toList();
    lastId = object['lastId'] ?? 0;
  }

  void addGroup(String name) {
    final group = Group(generateId(groups), name);
    groups.add(group);

    notifyListeners();
  }

  int generateId(List list) {
    lastId += 1;

    return lastId;
  }

  @override
  Future<void> notifyListeners() async {
    super.notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('Data', JsonEncoder().toString());
    final a = jsonEncode({'groups': groups, "lastId": lastId});
    print(a);

    prefs.setString('Data', a);
  }
}
