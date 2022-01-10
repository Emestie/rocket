import 'dart:math';

import 'package:flutter/material.dart';

String _getAcronym(String text) {
  String uppers = "";

  var hasUppers = text.characters
      .where((p0) =>
          p0 != "." &&
          p0 != " " &&
          p0 != "-" &&
          p0 != "_" &&
          p0 == p0.toUpperCase())
      .isNotEmpty;

  for (var i = 0; i < text.length; i++) {
    if (uppers.length >= 3) break;
    if (text[i] != " " &&
        text[i] != "." &&
        text[i] != "-" &&
        text[i] != "_" &&
        ((hasUppers && i != 0) ? (text[i] == text[i].toUpperCase()) : true)) {
      uppers += (text[i]);
    }
  }

  return uppers.toUpperCase();
}

Color _getColor(String text) {
  var charCodes = text.codeUnits;
  var sum = (charCodes).reduce((value, element) => value + element);

  var index = sum % Colors.primaries.length;

  Color _randomColor = Colors.primaries[index];

  return _randomColor;
}

class AcronymAvatar extends StatelessWidget {
  AcronymAvatar(this.text, {Key? key, this.size = 45})
      : acronym = _getAcronym(text),
        color = _getColor(text),
        super(key: key);

  final String text;
  final double size;

  final String acronym;
  final Color color;

  Color _getTextColor() {
    return (HSLColor.fromColor(color).lightness < 0.8
        ? Colors.white
        : Colors.black87);
  }

  double _getFontSize() {
    return size /
        (acronym.length == 3
            ? 3.0
            : acronym.length == 2
                ? 2.5
                : 1.8);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150), color: color),
        width: size,
        height: size,
        child: Center(
          child: Text(
            acronym,
            style: TextStyle(
              color: _getTextColor(),
              fontSize: _getFontSize(),
            ),
          ),
        ));
  }
}
