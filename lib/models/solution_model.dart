import 'package:rocket/models/solution_type_model.dart';

class Solution {
  int id;
  int groupId;
  int typeId;
  String name;
  String path;
  late bool isPinned;

  SolutionType get type => getSolutionTypeById(typeId);

  void start() {
    // print('started' + this.id.toString());
    type.startMethod(path);
  }

  Solution(this.id, this.groupId, this.typeId, this.name, this.path) {
    isPinned = false;
  }

  Solution.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        isPinned = json['isPinned'],
        path = json['path'],
        groupId = json['groupId'],
        typeId = json['typeId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'typeId': typeId,
        'name': name,
        'path': path,
        'isPinned': isPinned
      };
}
