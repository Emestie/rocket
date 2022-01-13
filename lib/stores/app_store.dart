import 'package:flutter/material.dart';
import 'package:rocket/enums.dart';

class AppStore extends ChangeNotifier {
  AppMode _mode = AppMode.view;
  bool hasUpdate = false;
  get mode => _mode;

  void setAppMode(AppMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void toggleAppMode() {
    _mode = _mode == AppMode.view ? AppMode.edit : AppMode.view;
    notifyListeners();
  }

  void setHasUpdate(bool hasUpdate) {
    this.hasUpdate = hasUpdate;
    notifyListeners();
  }
}
