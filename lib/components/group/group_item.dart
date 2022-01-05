import 'package:flutter/material.dart';
import 'package:rocket/models/group.dart';

class GroupItem extends StatelessWidget {
  Group _group;

  GroupItem(this._group, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Group " + _group.id.toString());
  }
}
