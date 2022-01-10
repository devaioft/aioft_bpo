import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> Message(
    context, content) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          content.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )),
  );
}
