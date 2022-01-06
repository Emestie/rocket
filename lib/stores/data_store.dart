import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rocket/models/group_model.dart';
import 'package:rocket/models/solution_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore extends ChangeNotifier {
  final List<Group> _groups = [];
  final List<Solution> _solutions = [];
  int lastId = 0;

  List<Group> get groups {
    final allGroups = _groups;
    allGroups
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final pinnedGroups =
        allGroups.where((element) => element.isPinned).toList();
    final unpinnedGroups =
        allGroups.where((element) => !element.isPinned).toList();

    final sortedGroups = [...pinnedGroups, ...unpinnedGroups];

    return sortedGroups;
  }

  List<Solution> getSolutionsByGroupId(int id) {
    return _solutions.where((element) => element.groupId == id).toList();
  }

  void addGroup(String name) {
    final group = Group(generateId(_groups), name);
    _groups.add(group);

    notifyListeners();
  }

  void editGroup(Group group, String name) {
    _groups.remove(group);
    group.name = name;
    _groups.add(group);

    notifyListeners();
  }

  void removeGroup(Group group) {
    _groups.remove(group);

    notifyListeners();
  }

  void togglePinGroup(Group group) {
    _groups.remove(group);
    group.isPinned = !group.isPinned;
    _groups.add(group);

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

    final jsonString = jsonEncode(
        {'groups': _groups, 'solutions': _solutions, "lastId": lastId});
    print(jsonString);

    prefs.setString('Data', jsonString);
  }

  DataStore(SharedPreferences prefs) {
    final json = prefs.getString('Data') ?? "{}";
    final decodedJsonObject = jsonDecode(json);

    final jsonGroups = (decodedJsonObject['groups'] ?? []);
    final jsonSolutions = (decodedJsonObject['solutions'] ?? []);

    for (var i = 0; i < jsonGroups.length; i++) {
      _groups.add(Group.fromJson(jsonGroups[i]));
    }

    for (var i = 0; i < jsonSolutions.length; i++) {
      _solutions.add(Solution.fromJson(jsonSolutions[i]));
    }

    lastId = decodedJsonObject['lastId'] ?? 0;
  }
}
