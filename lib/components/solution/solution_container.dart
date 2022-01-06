import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/stores/data_store.dart';

class SolutionContainer extends StatelessWidget {
  SolutionContainer(this.groupId, {Key? key}) : super(key: key);
  int groupId;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataStore>(builder: (_, data, __) {
      final solutions = data.getSolutionsByGroupId(groupId);

      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: solutions.length + 1,
        itemBuilder: (context, i) {
          if (i < solutions.length) {
            return Text("Sol Item");
          }

          return IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_box),
          );
        },
      );
    });
  }
}
