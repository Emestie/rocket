import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/group/group_item.dart';
import 'package:rocket/stores/data.dart';

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
            if (i >= groups.length) {
              return IconButton(
                onPressed: () {
                  data.addGroup("test");
                },
                icon: const Icon(Icons.add_alarm),
              );
            }
            return GroupItem(groups[i]);
          });
    });
  }
}
