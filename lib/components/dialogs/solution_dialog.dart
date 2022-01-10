import 'package:flutter/material.dart';
import 'package:rocket/models/solution_model.dart';
import 'package:rocket/models/solution_type_model.dart';
import 'package:rocket/stores/exposed.dart';

Future<void> showSolutionDialog(BuildContext context,
    {required Function(String text) onSave, Solution? solution}) async {
  var solPath = solution?.path ?? "";
  var solName = solution?.name ?? "";

  TextEditingController _solPathController =
      TextEditingController(text: solPath);

  TextEditingController _solNameController =
      TextEditingController(text: solName);

  final solutionTypes = getAvailableSolutionTypes();
  final groups = dataStore?.groups;

  List<Widget> _getGroupPicker() {
    if (solution == null) return [];
    return [
      Container(
        padding: const EdgeInsets.only(top: 10),
        child: const Text(
          "Solution group",
          // textAlign: TextAlign.left,
          style: TextStyle(fontSize: 12),
        ),
      ),
      DropdownButton(
          items: groups
              ?.map((e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  ))
              .toList(),
          onChanged: (_) {}),
    ];
  }

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(solution == null
              ? "Add new Solution"
              : "Edit Solution '" + solution.name + "'"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._getGroupPicker(),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  "Solution type",
                  // textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              DropdownButton(
                  items: solutionTypes
                      .map((e) => DropdownMenuItem(
                            child: Row(children: [e.icon, Text("  " + e.name)]),
                            value: e.id,
                          ))
                      .toList(),
                  onChanged: (_) {}),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  "Path to solution or folder",
                  // textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              TextField(
                autofocus: true,
                //maxLength: maxLength,
                onChanged: (value) {
                  solPath = value;
                },
                controller: _solPathController,
                decoration: const InputDecoration(
                    hintText: "Full path to solution or folder"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  "Solution name",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              TextField(
                autofocus: true,
                maxLength: 50,
                onChanged: (value) {
                  solName = value;
                },
                controller: _solNameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                //valueText = "";
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Save"),
              onPressed: () {
                onSave("");
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
