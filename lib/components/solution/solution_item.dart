import 'package:flutter/material.dart';
import 'package:rocket/models/solution_model.dart';

class SolutionItem extends StatelessWidget {
  const SolutionItem(this._solution, {Key? key}) : super(key: key);

  final Solution _solution;

  @override
  Widget build(BuildContext context) {
    return Text("Sol" + _solution.id.toString());
  }
}
