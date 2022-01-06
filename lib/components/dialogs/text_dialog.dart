import 'package:flutter/material.dart';

Future<void> showTextDialog(
  BuildContext context, {
  required String title,
  String defaultValue = "",
  String hintText = "",
  int maxLength = 30,
  String okText = "OK",
  String cancelText = "Cancel",
  required Function(String text) onOk,
}) async {
  TextEditingController _textFieldController =
      TextEditingController(text: defaultValue);
  var valueText = defaultValue;

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            autofocus: true,
            maxLength: maxLength,
            onChanged: (value) {
              valueText = value;
            },
            controller: _textFieldController,
            decoration: InputDecoration(hintText: hintText),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                valueText = "";
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(okText),
              onPressed: () {
                onOk(valueText);
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
