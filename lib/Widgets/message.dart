import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> message(
    context, content) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: kBtnColor,
        content: Text(
          content.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )),
  );
}
