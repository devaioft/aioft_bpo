
import 'package:flutter/material.dart';

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/banner.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
