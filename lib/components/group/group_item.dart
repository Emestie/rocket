import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/dialogs/confirm_dialog.dart';
import 'package:rocket/components/dialogs/text_dialog.dart';
import 'package:rocket/components/solution/solution_container.dart';
import 'package:rocket/enums.dart';
import 'package:rocket/models/group_model.dart';
import 'package:rocket/stores/app_store.dart';
import 'package:rocket/stores/data_store.dart';

class GroupItem extends StatelessWidget {
  const GroupItem(this._group, {Key? key}) : super(key: key);

  final Group _group;

  List<Widget> _generateGroupFacade(
      BuildContext context, AppStore app, DataStore data) {
    final List<Widget> widgets = [];

    if (_group.isPinned) {
      widgets.add(const Icon(
        Icons.star_rate_rounded,
        size: 18,
        color: Colors.black87,
      ));
    }

    widgets.add(Text(_group.name));

    if (app.mode == AppMode.view) return widgets;

    widgets.addAll([
      TextButton(
          onPressed: () {
            data.togglePinGroup(_group);
          },
          child: _group.isPinned
              ? const Text(
                  "Unpin",
                  style: TextStyle(fontSize: 13),
                )
              : const Text(
                  "Pin",
                  style: TextStyle(fontSize: 13),
                )),
      TextButton(
          onPressed: () {
            showTextDialog(context,
                title: "Rename Group",
                hintText: "Enter new name for Group",
                defaultValue: _group.name, onOk: (text) {
              data.editGroup(_group, text == "" ? _group.name : text);
            });
          },
          child: const Text(
            "Rename",
            style: TextStyle(fontSize: 13),
          )),
      TextButton(
          onPressed: () {
            void removeGroup() {
              data.removeGroup(_group);
            }

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
          child: const Text(
            "Remove",
            style: TextStyle(fontSize: 13),
          )),
    ]);

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Consumer<AppStore>(
          builder: (_, app, __) => Consumer<DataStore>(
            builder: (_, data, __) => Row(
              children: _generateGroupFacade(context, app, data),
            ),
          ),
        ),
      ),
      SolutionContainer(_group.id),
      const Divider(
        thickness: 2,
      ),
    ]);
  }
}
