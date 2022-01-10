import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/dialogs/solution_dialog.dart';
import 'package:rocket/components/solution/solution_item.dart';
import 'package:rocket/models/solution_model.dart';
import 'package:rocket/stores/data_store.dart';

class SolutionContainer extends StatelessWidget {
  const SolutionContainer(this.groupId, {Key? key}) : super(key: key);
  final int groupId;

  List<Widget> _generateSolutionsList(List<Solution> solutions) {
    List<Widget> returnee = solutions.map((sol) => SolutionItem(sol)).toList();

    return returnee;
  }

  Container _createAddButton(BuildContext context, DataStore data) {
    return Container(
        padding: const EdgeInsets.only(top: 8, left: 20),
        child: IconButton(
            onPressed: () {
              //data.addSolution(groupId, 'NewSolutionMoreText.sln');
              showSolutionDialog(context, onSave: (_) {});
            },
            icon: const Icon(Icons.add)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataStore>(builder: (_, data, __) {
      final solutions = data.getSolutionsByGroupId(groupId);

      return Wrap(alignment: WrapAlignment.start, children: [
        ..._generateSolutionsList(solutions),
        _createAddButton(context, data)
      ]);
    });
  }
}
