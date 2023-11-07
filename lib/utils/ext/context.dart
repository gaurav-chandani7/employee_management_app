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
}
