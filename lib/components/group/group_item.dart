import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/dialogs/confirm_dialog.dart';
import 'package:rocket/components/dialogs/text_dialog.dart';
import 'package:rocket/components/solution/solution_container.dart';
import 'package:rocket/models/group_model.dart';
import 'package:rocket/stores/data_store.dart';

class GroupItem extends StatelessWidget {
  final Group _group;

  const GroupItem(this._group, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("ID:" +
            _group.id.toString() +
            " " +
            _group.name +
            (_group.isPinned ? " P" : " _")),
        Consumer<DataStore>(
          builder: (_, data, __) {
            return TextButton(
                onPressed: () {
                  data.togglePinGroup(_group);
                },
                child:
                    _group.isPinned ? const Text("Unpin") : const Text("Pin"));
          },
        ),
        Consumer<DataStore>(
          builder: (_, data, __) {
            return TextButton(
                onPressed: () {
                  showTextDialog(context,
                      title: "Rename Group",
                      hintText: "Enter new name for Group",
                      defaultValue: _group.name, onOk: (text) {
                    data.editGroup(_group, text == "" ? _group.name : text);
                  });
                },
                child: const Text("Rename"));
          },
        ),
        Consumer<DataStore>(
          builder: (_, data, __) {
            return TextButton(
                onPressed: () {
                  void removeGroup() {
                    data.removeGroup(_group);
                  }

                  //todo: add confirmation if group is not empty
                  if (!_group.canRemove) {
                    showConfirmDialog(context,
                        title: "Confirm Group removing",
                        text:
                            "This Group has some Solutions inside. Are you sure you want to remove it? Solutions will be removed too.",
                        onOk: removeGroup);
                  } else {
                    removeGroup();
                  }
                },
                child: const Text("Remove"));
          },
        ),
        //SolutionContainer(_group.id)
      ],
    );
  }
}
