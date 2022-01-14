import 'package:flutter/material.dart';
import 'package:rocket/components/dialogs/alert_dialog.dart';
import 'package:rocket/components/solution/dropdown.dart';
import 'package:rocket/models/solution_model.dart';
import 'package:rocket/models/solution_type_model.dart';
import 'package:rocket/stores/exposed.dart';

Future<void> showSolutionDialog(BuildContext context,
    {required Function(int groupId, int type, String path, String name) onSave,
    Solution? solution}) async {
  final solutionTypes = getAvailableSolutionTypes();
  final groups = dataStore!.groups;

  var solPath = solution?.path ?? "";
  var solName = solution?.name ?? "";
  var groupId = solution?.groupId ?? 0;
  var typeId = solution?.typeId;
  if (!solutionTypes.map((e) => e.id).toList().contains(typeId)) {
    typeId = null;
  }

  TextEditingController _solPathController =
      TextEditingController(text: solPath);

  TextEditingController _solNameController =
      TextEditingController(text: solName);

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
      Dropdown<int?>(
          value: groupId,
          items: groups
              .map((e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  ))
              .toList(),
          onChanged: (int? value) {
            groupId = value ?? 0;
          }),
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
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Dropdown<int?>(
                  items: solutionTypes
                      .map((e) => DropdownMenuItem(
                            child: Row(children: [e.icon, Text("  " + e.name)]),
                            value: e.id,
                          ))
                      .toList(),
                  value: typeId,
                  onChanged: (int? value) {
                    typeId = value ?? 0;
                  }),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  "Path to solution/folder or terminal command",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  solPath = value;
                  //if (solName == "") solName = _calcName(value);
                },
                controller: _solPathController,
                decoration: const InputDecoration(
                    hintText:
                        "Full path to solution/folder or terminal command"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  "Solution name",
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
              child: const Text("Save"),
              onPressed: () {
                var reqs = [];

                if (typeId == 0 || typeId == null) {
                  reqs.add("Solution type");
                }

                if (solPath == "") {
                  reqs.add("Path/Command");
                }

                if (solName == "") {
                  reqs.add("Name");
                }

                if (reqs.isNotEmpty) {
                  var alert = "Following fields are required and not filled: " +
                      reqs.join(", ") +
                      ".";
                  showAlertDialog(context, title: "Oops", text: alert);
                  return;
                }

                var solutionType = getSolutionTypeById(typeId ?? 0);

                var validationErrorText =
                    solutionType.validate(solPath, solName);
                if (validationErrorText != null) {
                  showAlertDialog(context,
                      title: "Oops", text: validationErrorText);
                  return;
                }

                onSave(groupId, typeId ?? 0, solPath, solName);
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
