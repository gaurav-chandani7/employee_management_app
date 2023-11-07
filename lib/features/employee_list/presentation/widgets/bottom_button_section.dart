import 'package:flutter/material.dart';

class BottomButtonSection extends StatelessWidget {
  const BottomButtonSection({super.key, required this.cancelOnPressed, required this.saveOnPressed});
  final void Function()? cancelOnPressed;
  final void Function()? saveOnPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: cancelOnPressed,
                  child: const Text("Cancel")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: saveOnPressed,
                  child: const Text("Save")),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
