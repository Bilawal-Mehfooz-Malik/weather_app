import 'package:flutter/material.dart';
import 'package:weather_app/src/localization/string_hardcoded.dart';

void showErrorDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Ok'.hardcoded),
          ),
        ],
      );
    },
  );
}

void twoButtonDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String leftButtonText,
  required String rightButtonText,
  required VoidCallback leftButtonAction,
  required VoidCallback rightButtonAction,
}) {
  showDialog(
    context: context,
    builder: (context) {
      final style = Theme.of(context);
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          // [Left Button]
          TextButton(
            style: ButtonStyle(
              foregroundColor:
                  WidgetStatePropertyAll(style.colorScheme.onSurface),
            ),
            onPressed: leftButtonAction,
            child: Text(leftButtonText),
          ),

          // [Right Button]
          TextButton(
            onPressed: rightButtonAction,
            child: Text(rightButtonText),
          ),
        ],
      );
    },
  );
}

void showCustomSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
  ));
}
