import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class DialogBodyWidget extends StatelessWidget {
  const DialogBodyWidget({
    Key? key,
    this.dialogTitle,
  }) : super(key: key);

  final String? dialogTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dialogTitle!,
          style: const TextStyle(
            color: kBtnColor,
            fontWeight: FontWeight.w600,
            fontSize: 32.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
