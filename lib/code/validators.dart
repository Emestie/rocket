String? emptyValidator(String path, String name) {}

String? validateVS(String path, String name) {
  if (!path.endsWith('.sln')) {
    return 'With selected solution type Visual Studio, path must target an .sln file.';
  }
}
