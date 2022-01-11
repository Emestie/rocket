import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket/components/dialogs/solution_dialog.dart';
import 'package:rocket/components/solution/acronym_avatar.dart';
import 'package:rocket/enums.dart';
import 'package:rocket/models/solution_model.dart';
import 'package:rocket/stores/app_store.dart';
import 'package:rocket/stores/exposed.dart';

class SolutionItem extends StatelessWidget {
  const SolutionItem(this._solution, {Key? key}) : super(key: key);

  final Solution _solution;

  List<Widget> _getStackContent(BuildContext context, AppMode appMode) {
    List<Widget> content = [AcronymAvatar(_solution.id.toString())];

    content.add(
      Positioned.fill(
        left: 34,
        top: 34,
        child: _solution.type.icon,
      ),
    );

    if (appMode == AppMode.view) return content;

    content.addAll([
      Positioned.fill(
        left: 28,
        bottom: 28,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              dataStore?.removeSolution(_solution);
            },
            icon: const Icon(Icons.delete_outline),
            iconSize: 14,
            color: Colors.red,
          ),
        ),
      ),
      Positioned.fill(
        right: 28,
        bottom: 28,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              showSolutionDialog(context,
                  onSave: (groupId, typeId, path, name) {
                dataStore!.editSolution(_solution, groupId, typeId, path, name);
              }, solution: _solution);
            },
            icon: const Icon(Icons.edit_outlined),
            iconSize: 14,
          ),
        ),
      ),
      Positioned.fill(
        right: 28,
        top: 28,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              dataStore?.togglePinSolution(_solution);
            },
            icon: _solution.isPinned
                ? const Icon(Icons.star_border)
                : const Icon(Icons.star),
            iconSize: 14,
          ),
        ),
      )
    ]);
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 80,
      decoration: const BoxDecoration(
          //color: Colors.black26,
          //border: Border.all(width: 3, color: Colors.black45)),
          //borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
      child: Column(
        children: [
          Consumer<AppStore>(
            builder: (_, app, __) => Stack(
              //clipBehavior: Clip.none,
              children: _getStackContent(context, app.mode),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _solution.isPinned ? ('★' + _solution.name) : _solution.name,
              style: const TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black54),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
