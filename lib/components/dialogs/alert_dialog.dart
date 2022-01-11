import 'package:flutter/material.dart';

Future<void> showAlertDialog(
  BuildContext context, {
  required String title,
  required String text,
}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
