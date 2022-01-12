import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rocket/models/group_model.dart';
import 'package:rocket/models/solution_model.dart';
import 'package:rocket/stores/exposed.dart';

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
    final allSolutions =
        _solutions.where((element) => element.groupId == id).toList();
    allSolutions
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final pinnedSols =
        allSolutions.where((element) => element.isPinned).toList();
    final unpinnedSols =
        allSolutions.where((element) => !element.isPinned).toList();

    final sortedSols = [...pinnedSols, ...unpinnedSols];

    return sortedSols;
  }

  void addGroup(String name) {
    final group = Group(generateId(), name);
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

  void addSolution(int groupId, int typeId, String path, String name) {
    final sol = Solution(generateId(), groupId, typeId, name, path);
    _solutions.add(sol);

    notifyListeners();
  }

  void editSolution(
      Solution solution, int groupId, int typeId, String path, String name) {
    _solutions.remove(solution);
    solution.typeId = typeId;
    solution.groupId = groupId;
    solution.path = path;
    solution.name = name;
    _solutions.add(solution);

    notifyListeners();
  }

  void removeSolution(Solution solution) {
    _solutions.remove(solution);

    notifyListeners();
  }

  void togglePinSolution(Solution solution) {
    _solutions.remove(solution);
    solution.isPinned = !solution.isPinned;
    _solutions.add(solution);

    notifyListeners();
  }

  int generateId() {
    lastId += 1;

    return lastId;
  }

  @override
  Future<void> notifyListeners() async {
    super.notifyListeners();

    final jsonString = jsonEncode(
        {'groups': _groups, 'solutions': _solutions, "lastId": lastId});
    //print(jsonString);

    sharedPreferences?.setString('Data', jsonString);
  }

  DataStore() {
    final json = sharedPreferences?.getString('Data') ?? "{}";
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
