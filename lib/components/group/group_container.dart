import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/dialogs/text_dialog.dart';
import 'package:rocket/components/group/group_item.dart';
import 'package:rocket/models/group_model.dart';
import 'package:rocket/stores/data_store.dart';

class GroupContainer extends StatelessWidget {
  const GroupContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataStore>(builder: (_, data, __) {
      final groups = data.groups;

      return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: groups.length + 1,
          itemBuilder: (context, i) {
            if (i < groups.length) {
              return GroupItem(groups[i]);
            }

            return IconButton(
              onPressed: () {
                final defaultValue = "Group " + (data.lastId + 1).toString();
                //data.addGroup("test");
                showTextDialog(context,
                    title: "Add Group",
                    okText: "Save",
                    defaultValue: defaultValue,
                    hintText: "Group name", onOk: (text) {
                  data.addGroup(text == "" ? defaultValue : text);
                });
              },
              icon: const Icon(Icons.add_alarm),
            );
          });
    });
  }
}
