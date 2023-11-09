import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Future<void> showLoading() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
            child: const Material(
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
            onWillPop: () async => false),
      );

  dismiss() => Navigator.pop(this);

  Future<SnackBarClosedReason> showToast(
      {required String message, String? actionName}) {
    return ScaffoldMessenger.of(this)
        .showSnackBar(SnackBar(
          content: Text(message),
          action: actionName != null
              ? SnackBarAction(
                  label: actionName,
                  onPressed: () {},
                )
              : null,
        ))
        .closed;
  }
}
