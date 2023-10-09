import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Icon(
        Icons.error,
        size: 36,
        color: Colors.redAccent,
      ),
      content: Wrap(
        children: [
          const Center(
              child: Text(
            "Algo deu errado!",
            style: TextStyle(fontSize: 20),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(content),
          )),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok')),
      ],
    );
  }
}
