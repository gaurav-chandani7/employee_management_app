import 'package:flutter/material.dart';

Future<bool?> showConfirmDeleteAlertDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this record?"),
            actions: [
              ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
              ElevatedButton(onPressed: () {}, child: const Text("Delete"))
            ],
          ));
}
