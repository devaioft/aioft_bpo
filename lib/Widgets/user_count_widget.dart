
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class UserCountWidget extends StatelessWidget {
  const UserCountWidget({
    Key? key,
    required this.userLength,
  }) : super(key: key);

  final int? userLength;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Text(
          "${userLength ?? 0} users",
          style: const TextStyle(
            color: kCardColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
