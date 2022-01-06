import 'package:flutter/material.dart';

Future<void> showConfirmDialog(
  BuildContext context, {
  required String title,
  String? text,
  String okText = "OK",
  String cancelText = "Cancel",
  required Function() onOk,
  Function()? onCancel,
}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text ?? ""),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                if (onCancel != null) onCancel();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(okText),
              onPressed: () {
                onOk();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
