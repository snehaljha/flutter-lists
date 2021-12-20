import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dialogs {
  static Future<dynamic> createOrRenameListDialog(bool isNew, BuildContext ct) {
    String buttonText = "Rename";
    TextEditingController tfController = TextEditingController();
    if (isNew) buttonText = "create";

    return showDialog(
        context: ct,
        builder: (ct) {
          return AlertDialog(
            title: const Text("List Name"),
            content: TextField(
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
            title: const Text("Delete"),
            content: const Text("(('_')) Are you sure about that?"),
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
