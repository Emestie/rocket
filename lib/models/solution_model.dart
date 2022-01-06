import 'package:flutter/material.dart';
import 'package:rocket/models/solution_type_model.dart';

class Solution {
  int id;
  int groupId;
  int typeId;
  String name;
  String path;
  String acronym;
  Color color;
  late bool isPinned;

  SolutionType get type => getSolutionTypeById(id);

  Solution(this.id, this.groupId, this.name, this.path, this.acronym,
      this.color, this.typeId) {
    isPinned = false;
  }

  Solution.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = Colors.red,
        isPinned = json['isPinned'],
        acronym = json['acronym'],
        path = json['path'],
        groupId = json['groupId'],
        typeId = json['typeId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'typeId': typeId,
        'name': name,
        'path': path,
        'acronym': acronym,
        'color': color.value.toString(),
        'isPinned': isPinned
      };
}
