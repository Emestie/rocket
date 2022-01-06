List<SolutionType> _solutionTypes = [
  SolutionType(1, 'Visual Studio'),
  SolutionType(2, 'VS Code')
];

SolutionType getSolutionTypeById(int id) {
  return _solutionTypes.firstWhere((element) => element.id == id);
}

class SolutionType {
  int id;
  String name;

  SolutionType(this.id, this.name);
}
