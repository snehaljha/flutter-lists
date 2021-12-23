import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moor_lists/theme/app_theme.dart';

class Dialogs {
  static Future<dynamic> createOrRenameListDialog(bool isNew, BuildContext ct) {
    String buttonText = "Rename";
    TextEditingController tfController = TextEditingController();
    if (isNew) buttonText = "create";

    return showDialog(
        context: ct,
        builder: (ct) {
          return AlertDialog(
            backgroundColor: AppTheme.colors.dialogBG,
            title: Text(
              "List Name",
              style: TextStyle(color: AppTheme.colors.dialogText),
            ),
            content: TextField(
              style: TextStyle(color: AppTheme.colors.dialogText),
              controller: tfController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ct).pop(tfController.text.toString());
                  },
                  child: Text(buttonText))
            ],
          );
        });
  }

  static Future<dynamic> deleteDialog(BuildContext ct) {
    return showDialog(
        context: ct,
        builder: (ct) {
          return AlertDialog(
            backgroundColor: AppTheme.colors.dialogBG,
            title: Text(
              "Delete",
              style: TextStyle(color: AppTheme.colors.dialogText),
            ),
            content: Text(
              "(('_')) Are you sure about that?",
              style: TextStyle(color: AppTheme.colors.dialogText),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ct).pop(true);
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}
