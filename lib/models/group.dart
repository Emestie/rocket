import 'package:flutter/material.dart';

class Group {
  int id;
  String name;
  late Color color;
  late bool isPinned;

  Group(this.id, this.name) {
    color = Colors.grey;
    isPinned = false;
  }

  Group.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = Colors.grey, // Color(json['color']),
        isPinned = json['isPinned'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color.value.toString(),
        'isPinned': isPinned
      };
}
