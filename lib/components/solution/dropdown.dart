// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Dropdown<T> extends StatefulWidget {
  Dropdown(
      {required this.items,
      required this.value,
      required this.onChanged,
      Key? key})
      : super(key: key);

  List<DropdownMenuItem<T>> items;
  T value;
  Function(T? value) onChanged;

  @override
  State<StatefulWidget> createState() =>
      _DropdownState<T>(items, value, onChanged);
}

class _DropdownState<T> extends State<Dropdown> {
  _DropdownState(this.items, this.value, this.onChanged);

  List<DropdownMenuItem<T>> items;
  T? value;
  Function(T? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: items,
      onChanged: (T? val) {
        setState(() {
          value = val;
        });
        onChanged(val);
      },
    );
  }
}
